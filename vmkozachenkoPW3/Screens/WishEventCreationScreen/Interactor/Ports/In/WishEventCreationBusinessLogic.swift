//
//  WishEventCreationBusinessLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation

protocol WishEventCreationBusinessLogic: AnyObject {
    typealias Model = WishEventCreationModels
    
    func start()
    
    func loadAddEvent(_ request: Model.CreateEvent.Request)
}
