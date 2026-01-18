import Foundation

// MARK: - Business logic

protocol MainScreenBusinessLogic {
    typealias Model = MainScreenModel

    func loadStart(_ request: Model.Start.Request)

    func loadChangeColor(_ request: Model.ChangeColor.Request)

    func loadChangeColorController(
        _ request: Model.ChangeColorController.Request
    )

    func loadChangeToWishTableScreen(
        _ request: Model.ChangeToWishTableScreen.Request
    )
    
    func loadChangeToWishCalendarScreen()
}

// MARK: - Presentation logic

protocol MainScreenPresentationLogic {
    typealias Model = MainScreenModel

    func presentStart(_ response: Model.Start.Response)

    func presentChangeColor(_ response: Model.ChangeColor.Response)

    func presentChangeColorController(
        _ response: Model.ChangeColorController.Response
    )

    func changeToWishTableScreen(
        _ response: Model.ChangeToWishTableScreen.Response
    )
    
    func changeToWishCalendarScreen()
}
