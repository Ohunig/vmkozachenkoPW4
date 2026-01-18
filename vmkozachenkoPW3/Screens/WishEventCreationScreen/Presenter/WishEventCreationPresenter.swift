//
//  WishEventCreationPresenter.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation

final class WishEventCreationPresenter: WishEventCreationPresentationLogic {
    
    weak var view: WishEventCreationViewController?
    
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
    
    func changeToWishCalendarScreen() {
        <#code#>
    }
}
