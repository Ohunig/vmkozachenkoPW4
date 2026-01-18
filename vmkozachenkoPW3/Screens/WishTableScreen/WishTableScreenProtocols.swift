import Foundation

// MARK: - Business logic

protocol WishTableScreenBusinessLogic {
    typealias Model = WishTableScreenModel

    func loadStart(_ request: Model.Start.Request)
    
    func loadUpdateWishes(_ request: Model.UpdateWishes.Request)
}

// MARK: Presentation logic

protocol WishTableScreenPresentationLogic {
    typealias Model = WishTableScreenModel

    func presentStart(_ response: Model.Start.Response)
    
    func presentUpdateWishes(_ response: Model.UpdateWishes.Response)
}
