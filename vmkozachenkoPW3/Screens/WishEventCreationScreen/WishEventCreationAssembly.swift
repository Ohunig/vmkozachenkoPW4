//
//  WishEventCreationAssembly.swift
//  vmkozachenkoPW3
//
//  Created by User on 19.01.2026.
//

import Foundation
import UIKit

enum WishEventCreationAssembly {
    
    static func build(
        eventCreationDelegate: WishEventCreationDelegate?
    ) -> UIViewController {
        let presenter = WishEventCreationPresenter()
        let interactor = WishEventCreationInteractor(
            presenter: presenter,
            colorManager: ColorManager.shared,
            eventRepository: WishEventRepository.shared
        )
        let viewController = WishEventCreationViewController(
            interactor: interactor
        )
        viewController.eventCreationDelegate = eventCreationDelegate
        presenter.view = viewController
        
        return viewController
    }
}
