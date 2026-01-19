//
//  WishCalendarPresentationLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation

protocol WishCalendarPresentationLogic: AnyObject {
    typealias Model = WishCalendarModels
    
    func presentStart(_ response: Model.Start.Response)
    
    func goToMainScreen()
    
    func goToAddEvent()
}
