//
//  WishStoringLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 15.01.2026.
//

import Foundation

protocol WishStoringLogic {
    var count: Int { get }
    
    func start()

    func getWishById(id: Int) -> String?
    
    func setWishTo(id: Int, wish: String)

    func addWish(wish: String)
    
    func deleteWish(index: Int)
}
