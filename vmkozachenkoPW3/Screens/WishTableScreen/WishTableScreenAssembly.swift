import Foundation

enum WishTableScreenAssembly {

    static func build() -> WishStoringViewController {
        let presenter: WishTableScreenPresenter = WishTableScreenPresenter()
        let interactor: WishTableScreenInteractor = WishTableScreenInteractor(
            presenter: presenter,
            colorManager: ColorManager.shared,
            wishManager: WishStoringManager.shared
        )
        let viewController: WishStoringViewController =
            WishStoringViewController(interactor: interactor)

        presenter.view = viewController

        return viewController
    }
}
