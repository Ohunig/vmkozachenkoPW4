//
//  WishEventCreationPresentationLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation

protocol WishEventCreationPresentationLogic: AnyObject {
    typealias Model = WishEventCreationModels
    
    func presentStart(_ response: Model.Start.Response)
    
    func changeToWishCalendarScreen()
}
