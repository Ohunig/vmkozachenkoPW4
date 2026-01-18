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
    
    // MARK: Lifecycle
    
    init(
        presenter: WishEventCreationPresentationLogic,
        colorManager: ColorManagerLogic
    ) {
        self.presenter = presenter
        self.colorManager = colorManager
    }
    
    func start() {
        presenter.presentStart(
            Model.Start.Response(
                color: colorManager.color
            )
        )
    }
    
    func loadAddEvent(_ request: Model.CreateEvent.Request) {
        <#code#>
    }
    
}
