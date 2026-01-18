import Foundation

final class ColorManager: ColorManagerLogic {
    
    // MARK: - Constants
    
    private enum Constants {
        static let startColor: String = "#082b11"
    }
    
    // MARK: - Fields
    
    static let shared: ColorManagerLogic = ColorManager()
    
    var color: ColorModel = .init(hex: Constants.startColor)
    
    // MARK: - Inits
    
    private init() {}
    
    // MARK: - Set color
    
    func setColor(color: ColorModel) {
        self.color = color
    }
}
