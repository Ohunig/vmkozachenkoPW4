import Foundation

final class WishTableScreenPresenter: WishTableScreenPresentationLogic {

    // MARK: - Fields

    weak var view: WishStoringViewController?

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

    // MARK: - Present update wishes

    func presentUpdateWishes(_ response: Model.UpdateWishes.Response) {
        var wishes: [String] = Array(
            repeating: "",
            count: response.wishes.count
        )
        for i in 0..<response.wishes.count {
            wishes[i] = response.wishes[i] ?? "Wish is not loaded"
        }
        view?.displayUpdateWishes(Model.UpdateWishes.ViewModel(wishes: wishes))
    }
}
