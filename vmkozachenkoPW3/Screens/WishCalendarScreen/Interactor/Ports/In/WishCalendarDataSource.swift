//
//  WishCalendarDataSource.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation

protocol WishCalendarDataSource: AnyObject {
    
    var count: Int { get }
    
    func getWishEvent(at index: Int) -> WishEventModel?
}
