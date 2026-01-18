import Foundation

final class MainScreenInteractor: MainScreenBusinessLogic {

    // MARK: - Constants

    private enum Constants {
        static let maxColorValue: CGFloat = 255

        static let alphaValue: CGFloat = 1
        static let minValue: CGFloat = 0
        static let maxValue: CGFloat = 1
    }

    private enum ColorControllerType {
        case slider
        case textField
        case randomButton
    }

    // MARK: - Fields

    private let presenter: MainScreenPresentationLogic

    private var colorController: ColorControllerType

    private let colorManager: ColorManagerLogic

    // MARK: - Initialisers

    init(
        presenter: MainScreenPresentationLogic,
        colorManager: ColorManagerLogic
    ) {
        self.presenter = presenter
        self.colorManager = colorManager
        colorController = .slider
    }

    // MARK: Load Start

    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response(color: colorManager.color))
    }

    // MARK: - Load change color

    func loadChangeColor(_ request: Model.ChangeColor.Request) {
        switch request {

        case let .slider(red, green, blue):
            // color processing
            let r = min(
                max(red / Constants.maxColorValue, Constants.minValue),
                Constants.maxValue
            )
            let g = min(
                max(green / Constants.maxColorValue, Constants.minValue),
                Constants.maxValue
            )
            let b = min(
                max(blue / Constants.maxColorValue, Constants.minValue),
                Constants.maxValue
            )
            // set color
            colorManager.setColor(color: ColorModel(red: r, green: g, blue: b))

        case .randomButton:
            // set color
            colorManager.setColor(
                color: ColorModel(
                    red: CGFloat.random(in: 0...1),
                    green: CGFloat.random(in: 0...1),
                    blue: CGFloat.random(in: 0...1)
                )
            )

        case let .textField(hex):
            guard ColorModel.validateHEX(hex: hex) else { return }
            // set color
            colorManager.setColor(color: ColorModel(hex: hex))
        }

        presenter.presentChangeColor(
            Model.ChangeColor.Response(color: colorManager.color)
        )
    }

    // MARK: - Load change clr controller

    func loadChangeColorController(
        _ request: Model.ChangeColorController.Request
    ) {
        colorController =
            switch request.index {
            case 0: .slider
            case 1: .textField
            case 2: .randomButton
            default: .slider
            }
        let response: Model.ChangeColorController.Response =
            switch colorController {
            case .slider: .slider
            case .textField: .textField
            case .randomButton: .randomButton
            }
        presenter.presentChangeColorController(response)
    }

    // MARK: - Load wish table screen

    func loadChangeToWishTableScreen(
        _ request: Model.ChangeToWishTableScreen.Request
    ) {
        presenter.changeToWishTableScreen(
            Model.ChangeToWishTableScreen.Response()
        )
    }
    
    func loadChangeToWishCalendarScreen() {
        presenter.changeToWishCalendarScreen()
    }
}
