//
//  WishEventStoringLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation

protocol WishEventStoringLogic: AnyObject {
    var count: Int { get }
    
    func start()

    func getEventById(id: Int) -> WishEventModel?

    func addEvent(title: String, description: String, start: Date, end: Date)
}
