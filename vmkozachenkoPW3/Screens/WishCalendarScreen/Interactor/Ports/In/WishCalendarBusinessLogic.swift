//
//  WishCalendarBusinessLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation

protocol WishCalendarBusinessLogic: AnyObject {
    typealias Model = WishCalendarModels
    
    func loadStart()
    
    func loadGoToMainScreen()
    
    func loadGoToAddEvent()
}
