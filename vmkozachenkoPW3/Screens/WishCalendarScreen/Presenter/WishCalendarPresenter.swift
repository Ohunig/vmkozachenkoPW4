//
//  WishCalendarPresenter.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation

final class WishCalendarPresenter: WishCalendarPresentationLogic {
    
    weak var view: WishCalendarViewController?
    
    // MARK: Presentation
    
    func presentStart(_ response: Model.Start.Response) {
        let color = response.color
        view?.displayStart(
            Model.Start.ViewModel(
                red: color.red,
                green: color.green,
                blue: color.blue,
                alpha: color.alpha
            )
        )
    }
    
    func goToMainScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
}
