import Foundation

enum MainScreenAssembly {

    static func build() -> MainScreenViewController {
        let presenter: MainScreenPresenter = MainScreenPresenter()
        let interactor: MainScreenBusinessLogic = MainScreenInteractor(
            presenter: presenter,
            colorManager: ColorManager.shared
        )
        let viewController: MainScreenViewController = MainScreenViewController(
            interactor: interactor
        )
        presenter.view = viewController

        return viewController
    }
}
