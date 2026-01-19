//
//  WishCalendarInteractor.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation

final class WishCalendarInteractor: WishCalendarBusinessLogic {
    
    private let presenter: WishCalendarPresentationLogic
    
    private let colorManager: ColorManagerLogic
    
    private let repo: WishEventStoringLogic
    
    init(
        presenter: WishCalendarPresentationLogic,
        colorManager: ColorManagerLogic,
        repository: WishEventStoringLogic
    ) {
        self.presenter = presenter
        self.colorManager = colorManager
        self.repo = repository
    }
    
    // MARK: Use-cases
    
    func loadStart() {
        repo.start()
        presenter.presentStart(Model.Start.Response(color: colorManager.color))
    }
    
    func loadGoToMainScreen() {
        presenter.goToMainScreen()
    }
    
    func loadGoToAddEvent() {
        presenter.goToAddEvent()
    }
}

extension WishCalendarInteractor: WishCalendarDataSource {
    
    var count: Int {
        repo.count
    }
    
    func getWishEvent(at index: Int) -> WishEventModel? {
        return repo.getEventById(id: index)
    }
}
