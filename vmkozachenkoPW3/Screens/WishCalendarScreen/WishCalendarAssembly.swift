//
//  WishCalendarAssembly.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation
import UIKit

enum WishCalendarAssembly {
    
    static func build() -> UIViewController {
        let presenter = WishCalendarPresenter()
        let interactor = WishCalendarInteractor(
            presenter: presenter,
            colorManager: ColorManager.shared,
            repository: WishEventRepository.shared
        )
        let viewController = WishCalendarViewController(
            interactor: interactor,
            calendarDataSource: interactor
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
