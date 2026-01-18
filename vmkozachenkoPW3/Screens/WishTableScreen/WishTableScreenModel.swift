import Foundation

enum WishTableScreenModel {
    
    // MARK: - Start
    
    enum Start {
        struct Request { }
        struct Response {
            let color: ColorModel
        }
        struct ViewModel {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
    }
    
    // MARK: - Update wishes
    
    enum UpdateWishes {
        enum Request {
            case update
            case add(String)
            case delete(Int)
            case edit(Int, String)
        }
        struct Response {
            let wishes: [String?]
        }
        struct ViewModel {
            let wishes: [String]
        }
    }
}
