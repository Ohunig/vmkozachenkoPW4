import Foundation

final class MainScreenPresenter: MainScreenPresentationLogic {

    // MARK: - Fields
    weak var view: MainScreenViewController?

    // MARK: - Present start

    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(
            Model.Start.ViewModel(
                red: response.color.red,
                green: response.color.green,
                blue: response.color.blue
            )
        )
    }

    // MARK: - Present change color

    func presentChangeColor(_ response: Model.ChangeColor.Response) {
        view?.displayChangeColor(
            Model.ChangeColor.ViewModel(
                red: response.color.red,
                green: response.color.green,
                blue: response.color.blue
            )
        )
    }

    // MARK: - Present change clr controller

    func presentChangeColorController(
        _ response: Model.ChangeColorController.Response
    ) {
        var showSlider: Bool = false
        var showTextField: Bool = false
        var showRandomButton: Bool = false
        switch response {
        case .slider: showSlider = true
        case .textField: showTextField = true
        case .randomButton: showRandomButton = true
        }
        view?.displayChangeColorController(
            Model.ChangeColorController.ViewModel(
                showSlider: showSlider,
                showTextField: showTextField,
                showRandomButton: showRandomButton
            )
        )
    }

    // MARK: - Change screen

    func changeToWishTableScreen(
        _ response: Model.ChangeToWishTableScreen.Response
    ) {
        view?.navigationController?.pushViewController(
            WishTableScreenAssembly.build(),
            animated: true
        )
    }
    
    func changeToWishCalendarScreen() {
        view?.navigationController?.pushViewController(
            WishCalendarAssembly.build(),
            animated: true
        )
    }
}
