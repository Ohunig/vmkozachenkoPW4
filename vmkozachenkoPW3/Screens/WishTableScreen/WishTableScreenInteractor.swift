import Foundation

final class WishTableScreenInteractor: WishTableScreenBusinessLogic {

    // MARK: - Fields

    private let presenter: WishTableScreenPresentationLogic

    private let colorManager: ColorManagerLogic

    private var wishManager: WishStoringLogic

    // MARK: - Inits

    init(
        presenter: WishTableScreenPresentationLogic,
        colorManager: ColorManagerLogic,
        wishManager: WishStoringLogic
    ) {
        self.presenter = presenter
        self.colorManager = colorManager
        self.wishManager = wishManager
    }

    // MARK: - Load start

    func loadStart(_ request: Model.Start.Request) {
        wishManager.start()
        presenter.presentStart(Model.Start.Response(color: colorManager.color))
    }

    // MARK: - Load update wishes

    func loadUpdateWishes(_ request: Model.UpdateWishes.Request) {
        if case .add(let wish) = request {
            if !wish.isEmpty {
                wishManager.addWish(wish: wish)
            }
        } else if case .delete(let index) = request {
            wishManager.deleteWish(index: index)
        } else if case .edit(let index, let wish) = request {
            if !wish.isEmpty {
                wishManager.setWishTo(id: index, wish: wish)
            }
        }
        var resp: [String?] = Array(repeating: "", count: wishManager.count)
        for i in 0..<wishManager.count {
            resp[i] = wishManager.getWishById(id: i)
        }
        presenter.presentUpdateWishes(Model.UpdateWishes.Response(wishes: resp))
    }
}
