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
//    static func bunchOfSChoices(_ number: Int) -> UIColor? { UIColor(named: "ColorSelection\(number)") }
    
    static let bunchOfSChoices = [
        UIColor(named: "ColorSelection1")!,
        UIColor(named: "ColorSelection2")!,
        UIColor(named: "ColorSelection3")!,
        UIColor(named: "ColorSelection4")!,
        UIColor(named: "ColorSelection5")!,
        UIColor(named: "ColorSelection6")!,
        UIColor(named: "ColorSelection7")!,
        UIColor(named: "ColorSelection8")!,
        UIColor(named: "ColorSelection9")!,
        UIColor(named: "ColorSelection10")!,
        UIColor(named: "ColorSelection11")!,
        UIColor(named: "ColorSelection12")!,
        UIColor(named: "ColorSelection13")!,
        UIColor(named: "ColorSelection14")!,
        UIColor(named: "ColorSelection15")!,
        UIColor(named: "ColorSelection16")!,
        UIColor(named: "ColorSelection17")!,
        UIColor(named: "ColorSelection18")!
    ]
}
