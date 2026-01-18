import UIKit

final class CustomRGBSlider: UIView {

    // MARK: - Constants

    private enum Constants {
        static let stackCornerRadius: CGFloat = 20

        static let redSliderTitle = "Red"
        static let greenSliderTitle = "Green"
        static let blueSliderTitle = "Blue"

        static let sliderMin: CGFloat = 0
        static let sliderMax: CGFloat = 255
    }

    // MARK: - Fields

    var valueChanged: ((CGFloat, CGFloat, CGFloat) -> Void)?

    private let slidersStack = UIStackView()

    let redSlider = CustomSlider(
        title: Constants.redSliderTitle,
        minValue: Constants.sliderMin,
        maxValue: Constants.sliderMax
    )
    let greenSlider = CustomSlider(
        title: Constants.greenSliderTitle,
        minValue: Constants.sliderMin,
        maxValue: Constants.sliderMax
    )
    let blueSlider = CustomSlider(
        title: Constants.blueSliderTitle,
        minValue: Constants.sliderMin,
        maxValue: Constants.sliderMax
    )

    // MARK: - Initialisers

    init() {
        super.init(frame: .zero)

        redSlider.ValueChanged = { [weak self] in self?.anySliderChanged() }
        greenSlider.ValueChanged = { [weak self] in self?.anySliderChanged() }
        blueSlider.ValueChanged = { [weak self] in self?.anySliderChanged() }
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure UI

    private func configureUI() {
        // set stack settings
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.layer.cornerRadius = Constants.stackCornerRadius
        slidersStack.clipsToBounds = true
        slidersStack.axis = .vertical
        self.addSubview(slidersStack)

        // add sliders to slidersStack view
        for slider in [redSlider, greenSlider, blueSlider] {
            slider.translatesAutoresizingMaskIntoConstraints = false
            slidersStack.addArrangedSubview(slider)
        }

        NSLayoutConstraint.activate([
            slidersStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slidersStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            slidersStack.topAnchor.constraint(equalTo: self.topAnchor),
            slidersStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    // MARK: - Update slider values to last version

    func updateSliders(red: CGFloat, green: CGFloat, blue: CGFloat) {
        redSlider.setValue(value: red * Constants.sliderMax, notify: false)
        greenSlider.setValue(value: green * Constants.sliderMax, notify: false)
        blueSlider.setValue(value: blue * Constants.sliderMax, notify: false)
    }

    // MARK: - Any slider changed

    func anySliderChanged() {
        valueChanged?(
            redSlider.getValue(),
            greenSlider.getValue(),
            blueSlider.getValue()
        )
    }
}
