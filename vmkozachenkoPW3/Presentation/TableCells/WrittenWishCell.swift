import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"

        static let wrapColor: UIColor = UIColor(
            red: 1,
            green: 0.8,
            blue: 0.64,
            alpha: 1
        )
        static let wrapRadius: CGFloat = 12
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 8

        static let wishLabelOffset: CGFloat = 18

        static let menuButtonWidth: CGFloat = 30
    }

    // MARK: - Fields

    static let reuseId: String = "WrittenWishCell"

    private let wrap: UIView = UIView()

    private let wishLabel: UILabel = UILabel()

    private let menuButton: UIButton = UIButton(type: .system)

    var onDeleteTapped: (() -> Void)?

    var onEditTapped: (() -> Void)?

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.isUserInteractionEnabled = true

        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    // MARK: - Configure label

    func configure(with wish: String) {
        wishLabel.text = wish
    }

    // MARK: - Configure UI

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear

        configureWrap()
        configureMenuButton()
        configureWishLabel()
    }

    // MARK: - Configure Wrap

    private func configureWrap() {
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius

        // Add to self subwiews
        wrap.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrap)

        NSLayoutConstraint.activate([
            wrap.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrap.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: Constants.wrapOffsetH
            ),
            wrap.topAnchor.constraint(equalTo: self.topAnchor),
            wrap.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -Constants.wrapOffsetV
            ),
        ])
    }

    // MARK: - Configure Menu Button

    private func configureMenuButton() {
        // Add image, color of text
        menuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuButton.tintColor = .black

        // Add to wrap subwiews
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        wrap.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.trailingAnchor.constraint(
                equalTo: wrap.trailingAnchor,
                constant: -Constants.wishLabelOffset
            ),
            menuButton.centerYAnchor.constraint(equalTo: wrap.centerYAnchor),
            menuButton.topAnchor.constraint(
                equalTo: wrap.topAnchor,
                constant: Constants.wishLabelOffset
            ),
            menuButton.widthAnchor.constraint(
                equalToConstant: Constants.menuButtonWidth
            ),
        ])

        // Add menu
        let menu = UIMenu(children: [
            // Edit action
            UIAction(
                title: "Edit",
                image: UIImage(systemName: "pencil")
            ) {
                [weak self] _ in
                self?.onEditTapped?()
            },
            // Delete action
            UIAction(
                title: "Delete",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { [weak self] _ in
                self?.onDeleteTapped?()
            },
        ])

        // Set menu to menuButton
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }

    // MARK: - Configure Wish Label

    private func configureWishLabel() {
        wishLabel.textColor = .black
        wishLabel.numberOfLines = 0

        // Add to wrap subwiews
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        wrap.addSubview(wishLabel)

        NSLayoutConstraint.activate([
            wishLabel.centerYAnchor.constraint(equalTo: wrap.centerYAnchor),
            wishLabel.leadingAnchor.constraint(
                equalTo: wrap.leadingAnchor,
                constant: Constants.wishLabelOffset
            ),
            wishLabel.trailingAnchor.constraint(
                equalTo: menuButton.leadingAnchor
            ),
            wishLabel.topAnchor.constraint(
                equalTo: wrap.topAnchor,
                constant: Constants.wishLabelOffset
            ),
        ])
    }
}
