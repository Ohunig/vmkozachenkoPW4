import UIKit

final class WishStoringViewController: UIViewController {
    typealias Model = WishTableScreenModel

    // MARK: - Constants

    private enum Constants {
        static let fatalInitError = "init(coder:) has not been implemented"
        static let fatalTableError = "Invalid section number"

        static let tableCornerRadius: CGFloat = 12
        static let tableTop: CGFloat = 20
        static let tableLeading: CGFloat = 20
        static let tableBottom: CGFloat = -50
        
        static let alphaValue: CGFloat = 1

        static let countOfSections = 2
        
        static let backButtonTitle = "Back"
    }

    // MARK: - Fields

    private let interactor: WishTableScreenBusinessLogic

    private let table: UITableView = UITableView(frame: .zero)
    
    private var backButton: CustomBarButton = CustomBarButton()

    // The source of truth is in interactor
    private var wishes: [String] = []

    // MARK: - Initialisers

    init(interactor: WishTableScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalInitError)
    }

    // MARK: - View did load

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        interactor.loadStart(Model.Start.Request())
        interactor.loadUpdateWishes(.update)
    }

    // MARK: - Configure UI

    private func configureUI() {
        configureNavigationBar()
        configureTable()
    }

    // MARK: - Configure Navigation Bar

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        backButton = CustomBarButton(type: .system)
        backButton.title = Constants.backButtonTitle
        backButton.tapped = backTapped
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: backButton
        )
        navigationItem.leftBarButtonItem?.hidesSharedBackground = true
    }

    // MARK: - Configure table

    private func configureTable() {
        table.register(
            WrittenWishCell.self,
            forCellReuseIdentifier: WrittenWishCell.reuseId
        )
        table.register(
            AddWishCell.self,
            forCellReuseIdentifier: AddWishCell.reuseId
        )
        table.dataSource = self
        table.reloadData()
        table.isUserInteractionEnabled = true
        table.delaysContentTouches = false
        table.showsVerticalScrollIndicator = false

        // Set style
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            table.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.tableTop
            ),
            table.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.tableLeading
            ),
            table.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: Constants.tableBottom
            ),
        ])
    }

    // MARK: - Display changes

    func displayStart(_ viewModel: Model.Start.ViewModel) {
        let color = UIColor(
            red: viewModel.red,
            green: viewModel.green,
            blue: viewModel.blue,
            alpha: Constants.alphaValue
        )
        view.backgroundColor = color
        backButton.setTitleColor(color, for: .normal)
    }

    func displayUpdateWishes(_ viewModel: Model.UpdateWishes.ViewModel) {
        wishes = viewModel.wishes
        table.reloadData()
    }
}

// MARK: - Extention to UITableViewDataSource

extension WishStoringViewController: UITableViewDataSource {

    // MARK: - Get count of cells in section

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        switch section {
        case 0:
            return 1
        case 1:
            return wishes.count
        default:
            fatalError(Constants.fatalTableError)
        }
    }

    // MARK: - Get Table Cell

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            guard let addCell = cell as? AddWishCell else {
                return cell
            }

            // Add action to button
            addCell.buttonPressed = { [weak self] wish in
                self?.dismissKeyboard()
                self?.interactor.loadUpdateWishes(.add(wish))
            }
            return addCell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = cell as? WrittenWishCell else {
                return cell
            }
            wishCell.configure(with: wishes[indexPath.row])

            // Add action to delete button
            wishCell.onDeleteTapped = { [weak self] in
                self?.interactor.loadUpdateWishes(.delete(indexPath.row))
            }

            // Add action to edit button
            wishCell.onEditTapped = { [weak self] in
                let alert = UIAlertController(
                    title: "Edit Wish",
                    message: "Change your wish",
                    preferredStyle: .alert
                )

                // Add text field
                alert.addTextField { textField in
                    textField.text = self?.wishes[indexPath.row]
                    textField.placeholder = "Enter your wish"
                }

                // Add save action
                let saveAction = UIAlertAction(title: "Save", style: .default) {
                    [weak self] _ in
                    guard let textField = alert.textFields?.first,
                        let newText = textField.text,
                        !newText.isEmpty
                    else {
                        return
                    }

                    // Update data
                    self?.interactor.loadUpdateWishes(
                        .edit(indexPath.row, newText)
                    )
                }

                // Cancel button
                let cancelAction = UIAlertAction(
                    title: "Cancel",
                    style: .cancel
                )

                alert.addAction(saveAction)
                alert.addAction(cancelAction)

                self?.present(alert, animated: true)
            }

            return wishCell
        default:
            fatalError(Constants.fatalTableError)
        }
    }

    // MARK: - Number Of Section

    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.countOfSections
    }

    // MARK: - Back Tapped

    private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Dismiss Keyboard

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
