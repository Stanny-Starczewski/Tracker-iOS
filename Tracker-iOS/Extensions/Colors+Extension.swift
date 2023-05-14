import UIKit

extension UIColor {
    
    // MARK: - Interface (main) colors
    static var BlackDay: UIColor { UIColor(named: "BlackDay") ?? UIColor.black }
    static var BlackNight: UIColor { UIColor(named: "BlackNight") ?? UIColor.white }
    static var WhiteDay: UIColor { UIColor(named: "WhiteDay") ?? UIColor.white }
    static var WhiteNight: UIColor { UIColor(named: "WhiteNight") ?? UIColor.black }
    static var Blue: UIColor { UIColor(named: "Blue") ?? UIColor.blue }
    static var Red: UIColor { UIColor(named: "Red") ?? UIColor.red }
    static var BackgroundNight: UIColor { UIColor(named: "BackgroundNight") ?? UIColor.darkGray }
    static var Gray: UIColor { UIColor(named: "Gray") ?? UIColor.gray }
    static var LightGray: UIColor { UIColor(named: "LightGray") ?? UIColor.lightGray }
    static var BackgroundDay: UIColor { UIColor(named: "BackgroundDay") ?? UIColor.gray }
    
    // MARK: - ActionsCells (habits) colors
    static func bunchOfSChoices(_ number: Int) -> UIColor? { UIColor(named: "ColorSelection\(number)") }
}
