import Foundation
import UIKit

final class WishStoringManager: WishStoringLogic {
    
    // MARK: - Constants
    
    private enum Constants {        
        static let saveError: String = "Save error"
    }

    // MARK: Fields

    static let shared: WishStoringLogic = WishStoringManager()

    private var wishes: [Wish] = []

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var count: Int { wishes.count }

    // MARK: Lifecycle

    private init() {}

    // MARK: Behaviour
    
    func start() {
        do {
            try wishes = context.fetch(Wish.fetchRequest())
        }
        catch {
            wishes = []
        }
    }

    func getWishById(id: Int) -> String? {
        guard id >= 0 && id < wishes.count else { return nil }
        return wishes[id].message
    }
    
    func setWishTo(id: Int, wish: String) {
        guard id >= 0 && id < wishes.count else { return }
        wishes[id].message = wish
        // Save
        do {
            try context.save()
        }
        catch {
            print(Constants.saveError)
        }
    }
    
    func addWish(wish: String) {
        let newWish: Wish = Wish(context: context)
        newWish.message = wish
        wishes.append(newWish)
        // Save
        do {
            try context.save()
        }
        catch {
            print(Constants.saveError)
        }
    }
    
    func deleteWish(index: Int) {
        if (index >= 0 && index < count) {
            context.delete(wishes[index])
            wishes.remove(at: index)
        }
        // Save
        do {
            try context.save()
        }
        catch {
            print(Constants.saveError)
        }
    }
}
