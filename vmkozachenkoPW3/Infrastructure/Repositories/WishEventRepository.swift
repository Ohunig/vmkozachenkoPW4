//
//  WishEventRepository.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation
import UIKit

final class WishEventRepository: WishEventStoringLogic {
        
    private enum Constants {
        static let saveError: String = "Save error"
    }

    // MARK: Fields

    static let shared: WishEventStoringLogic = WishEventRepository()

    private var wishes: [WishEventModel] = []

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var count: Int { wishes.count }

    // MARK: Lifecycle

    private init() {}

    // MARK: Behaviour
    
    func start() {
        do {
            try wishes = context.fetch(WishEventModel.fetchRequest())
        }
        catch {
            wishes = []
        }
    }

    func getEventById(id: Int) -> WishEventModel? {
        guard id >= 0 && id < wishes.count else { return nil }
        return wishes[id]
    }
    
    func addEvent(title: String, description: String, start: Date, end: Date) {
        let newEvent = WishEventModel(context: context)
        newEvent.title = title
        newEvent.wishDescription = description
        newEvent.start = start
        newEvent.end = end
        wishes.append(newEvent)
        // Save
        do {
            try context.save()
        }
        catch {
            print(Constants.saveError)
        }
    }
}
