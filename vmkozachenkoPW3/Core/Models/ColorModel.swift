import Foundation

struct ColorModel {
    
    // MARK: - Constants
    
    private enum Constants {
        static let module = 255
        
        static let hexLength = 7
    }
    
    // MARK: - Fields
    
    public let red : CGFloat
    public let green : CGFloat
    public let blue : CGFloat
    public let alpha : CGFloat
    
    // MARK: - Standart constructor
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    // MARK: - Constructor from Hex
    
    public init(hex: String, alpha: CGFloat = 1) {
        if (ColorModel.validateHEX(hex: hex)) {
            let hexInt = Int(hex.suffix(hex.count - 1), radix: 16) ?? 0
            self.init(
                red: CGFloat(Float(hexInt >> 16) / Float(Constants.module)),
                green: CGFloat(Float((hexInt >> 8) & Constants.module) / Float(Constants.module)),
                blue: CGFloat(Float(hexInt & Constants.module) / Float(Constants.module)),
                alpha: CGFloat(alpha))
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
    
    // MARK: - HEX validator
    
    public static func validateHEX(hex: String) -> Bool {
        if (hex.count != Constants.hexLength || hex[hex.startIndex] != "#") {
            return false;
        }
        let hexSuff = hex.suffix(hex.count - 1)
        for symbol in hexSuff {
            if !("0"..."9").contains(symbol) && !("a"..."f").contains(symbol) && !("A"..."F").contains(symbol) {
                return false
            }
        }
        return true;
    }
}
