//
//  WishEventCreationInteractor.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation

final class WishEventCreationInteractor: WishEventCreationBusinessLogic {
    
    private let presenter: WishEventCreationPresentationLogic
    
    private let colorManager: ColorManagerLogic
    
    private let eventRepository: WishEventStoringLogic
    
    // MARK: Lifecycle
    
    init(
        presenter: WishEventCreationPresentationLogic,
        colorManager: ColorManagerLogic,
        eventRepository: WishEventStoringLogic
    ) {
        self.presenter = presenter
        self.colorManager = colorManager
        self.eventRepository = eventRepository
    }
    
    func start() {
        presenter.presentStart(
            Model.Start.Response(
                color: colorManager.color
            )
        )
    }
    
    func loadAddEvent(_ request: Model.CreateEvent.Request) {
        eventRepository.addEvent(
            title: request.title,
            description: request.description,
            start: request.start,
            end: request.end
        )
        presenter.changeToWishCalendarScreen()
    }
    
}
