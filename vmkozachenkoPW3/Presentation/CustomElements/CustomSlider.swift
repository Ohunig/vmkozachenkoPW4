import UIKit

final class CustomSlider: UIView {

    // MARK: - Constants

    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"

        static let titleTop: Double = 10
        static let titleLeading: Double = 20

        static let sliderTop: Double = 10
        static let sliderBottom: Double = -10
        static let sliderLeading: Double = 20
    }

    // MARK: - Fields

    var ValueChanged: (() -> Void)?

    private var suppressCallback = false

    private let slider = UISlider()
    private let title = UILabel()

    // MARK: - Initialisers

    init(title: String, minValue: Double, maxValue: Double) {
        super.init(frame: .zero)

        // set title and slider settings
        self.title.text = title
        self.title.textColor = .black
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.tintColor = .orange
        slider.addTarget(
            self,
            action: #selector(sliderValueChanged),
            for: .valueChanged
        )

        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    // MARK: - Configure UI

    private func configureUI() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false

        for view in [title, slider] {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Constants.titleTop
            ),
            title.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: Constants.titleLeading
            ),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            slider.topAnchor.constraint(
                equalTo: title.bottomAnchor,
                constant: Constants.sliderTop
            ),
            slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slider.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: Constants.sliderBottom
            ),
            slider.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.sliderLeading
            ),
        ])
    }

    // MARK: - Set value

    func setValue(value: Double, notify: Bool) {
        // if we don't want to call ValueChanged
        suppressCallback = !notify

        slider.value = Float(value)

        suppressCallback = false
    }

    // MARK: - Get value

    func getValue() -> Double {
        return Double(slider.value)
    }

    // MARK: - Slider value changed

    @objc
    private func sliderValueChanged() {
        guard !suppressCallback else { return }
        ValueChanged?()
    }
}
