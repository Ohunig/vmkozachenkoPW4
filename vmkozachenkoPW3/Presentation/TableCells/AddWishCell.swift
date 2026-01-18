import UIKit

final class AddWishCell: UITableViewCell {

    // MARK: - Constants

    private enum Constants {
        static let fatalError = "init(coder:) has not been implemented"

        static let placeholder: String = "Enter your wish"
        static let backgroundColor: UIColor = UIColor(
            red: 1,
            green: 0.8,
            blue: 0.64,
            alpha: 1
        )

        static let buttonTitle: String = "Add"
        static let buttonWidth: Double = 50

        static let textFieldOffset: CGFloat = 18

        static let wrapBottom: CGFloat = 10
    }

    // MARK: - Fields

    static let reuseId: String = "AddWishCell"

    var buttonPressed: ((String) -> Void)?

    private let textField = UITextField()
    private let sendButton = UIButton(type: .system)

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        sendButton.addTarget(
            self,
            action: #selector(buttonWasPressed),
            for: .touchDown
        )
        
        contentView.isUserInteractionEnabled = true

        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    // MARK: - Configure UI

    func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear

        // Wrap
        let wrap: UIView = UIView()
        wrap.backgroundColor = Constants.backgroundColor

        // Text field
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.placeholder,
            attributes: [.foregroundColor: UIColor.gray]
        )

        // Send Button
        sendButton.backgroundColor = .orange
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitle(Constants.buttonTitle, for: .normal)

        for view in [textField, sendButton, wrap] {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        wrap.addSubview(textField)
        wrap.addSubview(sendButton)
        self.addSubview(wrap)
        NSLayoutConstraint.activate([
            // wrap UI
            wrap.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrap.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrap.topAnchor.constraint(equalTo: self.topAnchor),
            wrap.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -Constants.wrapBottom
            ),

            // text field UI
            textField.leadingAnchor.constraint(
                equalTo: wrap.leadingAnchor,
                constant: Constants.textFieldOffset
            ),
            textField.topAnchor.constraint(
                equalTo: wrap.topAnchor,
                constant: Constants.textFieldOffset
            ),
            textField.bottomAnchor.constraint(
                equalTo: wrap.bottomAnchor,
                constant: -Constants.textFieldOffset
            ),

            // send button UI
            sendButton.leadingAnchor.constraint(
                equalTo: textField.trailingAnchor
            ),
            sendButton.trailingAnchor.constraint(
                equalTo: wrap.trailingAnchor
            ),
            sendButton.topAnchor.constraint(
                equalTo: wrap.topAnchor
            ),
            sendButton.bottomAnchor.constraint(
                equalTo: wrap.bottomAnchor,
            ),
            sendButton.widthAnchor.constraint(
                equalToConstant: Constants.buttonWidth
            ),
        ])
    }

    // MARK: - Button was pressed

    @objc
    func buttonWasPressed() {
        buttonPressed?(textField.text ?? "")
        textField.text = ""
    }
}
