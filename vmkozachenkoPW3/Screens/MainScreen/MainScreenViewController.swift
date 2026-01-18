import UIKit

final class MainScreenViewController: UIViewController {
    typealias Model = MainScreenModel

    // MARK: - Constants

    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"

        static let titleText = "Wish Maker"
        static let titleFontSize: CGFloat = 40
        static let titleLeading: CGFloat = 20
        static let titleTop: CGFloat = 20

        static let descriptionText =
            "This app will bring you joy and will fulfill three of your wishes!\n\t*The first wish is to change the background color."
        static let descriptionFontSize: CGFloat = 20
        static let descriptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 50

        static let sliderLeading: CGFloat = 20
        static let sliderTop: CGFloat = 30

        static let textFieldPlaceholder = "Write hex color"
        static let textFieldLeading: CGFloat = 50
        static let textFieldHeigh: CGFloat = 40
        static let textFieldCornerRadius: CGFloat = 8

        static let randomButtonTitle = "Random"
        static let randomButtonLeading: CGFloat = 100
        static let randomButtonHeight: CGFloat = 40
        static let randomButtonCornerRadius: CGFloat = 8

        static let segmentedControlFirst = "Slider"
        static let segmentedControlSecond = "HEX"
        static let segmentedControlThird = "Random"
        static let segmentedControlLeading: CGFloat = 30
        static let segmentedControlTop: CGFloat = 20
        static let segmetedControlSelectedSegmentIndex = 0

        static let addWishButtonTitle = "Add wish"
        static let addWishButtonCornerRadius: CGFloat = 8
        static let addWishButtonHeight: CGFloat = 40
        static let addWishButtonBottom: CGFloat = -20
        static let addWishButtonLeading: CGFloat = 60
        
        static let scheduleWishGrantingButtonText = "Schedule wish granting"
        static let scheduleWishGrantingButtonBottom: CGFloat = 20

        static let maxColorVal: CGFloat = 255

        static let alphaValue: CGFloat = 1
    }

    // MARK: - Fields
    
    lazy var headerStack : UIStackView = {
        let stack = UIStackView()
        return stack;
    }()

    private let interactor: MainScreenBusinessLogic

    private let mainTitle: UILabel = UILabel()
    private let mainDescription: UILabel = UILabel()

    private let segmentedControl = UISegmentedControl()

    // Color controllers
    private let rgbSlider: CustomRGBSlider = CustomRGBSlider()
    private let textField: CustomTextField = CustomTextField(
        placeholder: Constants.textFieldPlaceholder
    )
    private let randomButton: UIButton = UIButton(type: .system)

    private let addWishButton: UIButton = UIButton(type: .system)
    
    private let scheduleWishGrantingButton: UIButton = UIButton(type: .system)

    // MARK: - Initialisers

    init(interactor: MainScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    // MARK: - View did load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadStart(Model.Start.Request())
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
            )
        )
        configureUI()
    }
    
    // MARK: - view Is Appearing
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        // Hide Nav bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Configure UI

    private func configureUI() {
        configureTitle()
        configureDescription()
        configureSliders()
        configureTextField()
        configureRandomButton()
        configureSegmentedControl()
        configureAddWishButton()
        configureScheduleWishGrantingButton()
    }

    // MARK: - Configure Title

    private func configureTitle() {
        // customise title
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.text = Constants.titleText
        mainTitle.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        mainTitle.textColor = .orange

        // place title on view
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor,
                constant: Constants.titleLeading
            ),
            mainTitle.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.titleTop
            ),
        ])
    }

    // MARK: - Configure description

    private func configureDescription() {
        // customise description
        mainDescription.translatesAutoresizingMaskIntoConstraints = false
        mainDescription.text = Constants.descriptionText
        mainDescription.font = UIFont.systemFont(
            ofSize: Constants.descriptionFontSize
        )
        mainDescription.textColor = .orange
        mainDescription.numberOfLines = 0

        // place description on view
        view.addSubview(mainDescription)
        NSLayoutConstraint.activate([
            mainDescription.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            mainDescription.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.descriptionLeading
            ),
            mainDescription.topAnchor.constraint(
                equalTo: mainTitle.bottomAnchor,
                constant: Constants.descriptionTop
            ),
        ])
    }

    // MARK: - Configure Sliders

    private func configureSliders() {

        // assign valueChanged
        rgbSlider.valueChanged = { [weak self] red, green, blue in
            guard let self = self else { return }
            self.interactor.loadChangeColor(
                .slider(red: red, green: green, blue: blue)
            )
        }

        // add rgbSlider to view
        rgbSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rgbSlider)
        NSLayoutConstraint.activate([
            rgbSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rgbSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rgbSlider.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.sliderLeading
            ),
            rgbSlider.topAnchor.constraint(
                greaterThanOrEqualTo: mainDescription.bottomAnchor,
                constant: Constants.sliderTop
            ),
        ])
    }

    // MARK: - Configure Text Field

    private func configureTextField() {

        textField.buttonPressed = { [weak self] in
            guard let self = self else { return }

            self.dismissKeyboard()

            let hex = self.textField.getText()
            self.interactor.loadChangeColor(.textField(hex: hex))
        }

        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.textFieldLeading
            ),
            textField.heightAnchor.constraint(
                equalToConstant: Constants.textFieldHeigh
            ),
        ])
    }

    // MARK: - Configure random button

    private func configureRandomButton() {
        randomButton.addTarget(
            self,
            action: #selector(randomButtonTapped),
            for: .touchDown
        )
        randomButton.backgroundColor = .orange
        randomButton.setTitle(Constants.randomButtonTitle, for: .normal)
        randomButton.layer.cornerRadius = Constants.randomButtonCornerRadius
        randomButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            randomButton.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: Constants.randomButtonLeading
            ),
            randomButton.heightAnchor.constraint(
                equalToConstant: Constants.randomButtonHeight
            ),

        ])
    }

    // MARK: - Configure seg control

    private func configureSegmentedControl() {
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .orange
        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .normal
        )
        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        segmentedControl.insertSegment(
            withTitle: Constants.segmentedControlFirst,
            at: 0,
            animated: false
        )
        segmentedControl.insertSegment(
            withTitle: Constants.segmentedControlSecond,
            at: 1,
            animated: false
        )
        segmentedControl.insertSegment(
            withTitle: Constants.segmentedControlThird,
            at: 2,
            animated: false
        )

        segmentedControl.selectedSegmentIndex =
            Constants.segmetedControlSelectedSegmentIndex
        interactor.loadChangeColorController(
            Model.ChangeColorController.Request(
                index: segmentedControl.selectedSegmentIndex
            )
        )

        segmentedControl.addTarget(
            self,
            action: #selector(segmentControlTapped),
            for: .valueChanged
        )
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            segmentedControl.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.segmentedControlLeading
            ),
            segmentedControl.topAnchor.constraint(
                equalTo: rgbSlider.bottomAnchor,
                constant: Constants.segmentedControlTop
            ),
        ])
    }

    // MARK: Configure add wish button

    private func configureAddWishButton() {
        addWishButton.backgroundColor = .orange
        addWishButton.tintColor = .white
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.layer.cornerRadius = Constants.addWishButtonCornerRadius
        addWishButton.translatesAutoresizingMaskIntoConstraints = false

        addWishButton.addTarget(
            self,
            action: #selector(addWishButtonTapped),
            for: .touchDown
        )

        view.addSubview(addWishButton)
        NSLayoutConstraint.activate([
            addWishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addWishButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.addWishButtonLeading
            ),
            addWishButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: Constants.addWishButtonBottom
            ),
            addWishButton.heightAnchor.constraint(
                equalToConstant: Constants.addWishButtonHeight
            ),
        ])
    }
    
    // MARK: Configure schedule wish granting button
    
    private func configureScheduleWishGrantingButton() {
        scheduleWishGrantingButton.backgroundColor = .orange
        scheduleWishGrantingButton.tintColor = .white
        scheduleWishGrantingButton.setTitle(
            Constants.scheduleWishGrantingButtonText,
            for: .normal
        )
        scheduleWishGrantingButton.layer.cornerRadius = Constants.addWishButtonCornerRadius
        scheduleWishGrantingButton.translatesAutoresizingMaskIntoConstraints = false

        scheduleWishGrantingButton.addTarget(
            self,
            action: #selector(scheduleWishGrantingButtonTapped),
            for: .touchDown
        )

        view.addSubview(scheduleWishGrantingButton)
        NSLayoutConstraint.activate([
            scheduleWishGrantingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scheduleWishGrantingButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.addWishButtonLeading
            ),
            scheduleWishGrantingButton.bottomAnchor.constraint(
                equalTo: addWishButton.topAnchor,
                constant: -Constants.scheduleWishGrantingButtonBottom
            ),
            scheduleWishGrantingButton.heightAnchor.constraint(
                equalToConstant: Constants.addWishButtonHeight
            ),
        ])
    }

    // MARK: - Display changes

    func displayStart(_ viewModel: Model.Start.ViewModel) {
        displayChangeColor(
            Model.ChangeColor.ViewModel(
                red: viewModel.red,
                green: viewModel.green,
                blue: viewModel.blue
            )
        )
    }

    func displayChangeColor(_ viewModel: Model.ChangeColor.ViewModel) {
        rgbSlider.updateSliders(
            red: viewModel.red,
            green: viewModel.green,
            blue: viewModel.blue
        )
        let color = UIColor(
            red: viewModel.red,
            green: viewModel.green,
            blue: viewModel.blue,
            alpha: Constants.alphaValue
        )
        view.backgroundColor = color
        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: color],
            for: .normal
        )
        textField.setButtonTitleColor(color)
        randomButton.setTitleColor(color, for: .normal)
        addWishButton.setTitleColor(color, for: .normal)
        scheduleWishGrantingButton.setTitleColor(color, for: .normal)
    }

    func displayChangeColorController(
        _ viewModel: Model.ChangeColorController.ViewModel
    ) {
        rgbSlider.isHidden = !viewModel.showSlider
        textField.isHidden = !viewModel.showTextField
        randomButton.isHidden = !viewModel.showRandomButton
    }

    // MARK: - Random button tapped

    @objc
    private func randomButtonTapped() {
        interactor.loadChangeColor(.randomButton)
    }

    // MARK: - Segment control tapped

    @objc
    private func segmentControlTapped() {
        interactor.loadChangeColorController(
            Model.ChangeColorController.Request(
                index: segmentedControl.selectedSegmentIndex
            )
        )
    }

    // MARK: - Add wish button tapped

    @objc
    private func addWishButtonTapped() {
        interactor.loadChangeToWishTableScreen(
            Model.ChangeToWishTableScreen.Request()
        )
    }
    
    @objc
    private func scheduleWishGrantingButtonTapped() {
        interactor.loadChangeToWishCalendarScreen()
    }

    // MARK: - Dismiss Keyboard

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
