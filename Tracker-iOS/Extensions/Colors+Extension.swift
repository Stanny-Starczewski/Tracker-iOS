import UIKit

extension UIColor {
    
    // MARK: - Interface (main) colors
    static var ypBlackDay: UIColor { UIColor(named: "BlackDay") ?? UIColor.black }
    static var ypBlackNight: UIColor { UIColor(named: "BlackNight") ?? UIColor.white }
    static var ypWhiteDay: UIColor { UIColor(named: "WhiteDay") ?? UIColor.white }
    static var ypWhiteNight: UIColor { UIColor(named: "WhiteNight") ?? UIColor.black }
    static var ypBlue: UIColor { UIColor(named: "Blue") ?? UIColor.blue }
    static var ypRed: UIColor { UIColor(named: "Red") ?? UIColor.red }
    static var ypBackgroundNight: UIColor { UIColor(named: "BackgroundNight") ?? UIColor.darkGray }
    static var ypGray: UIColor { UIColor(named: "Gray") ?? UIColor.gray }
    static var ypLightGray: UIColor { UIColor(named: "LightGray") ?? UIColor.lightGray }
    static var ypBackgroundDay: UIColor { UIColor(named: "BackgroundDay") ?? UIColor.gray }
    
    // MARK: - ActionsCells (habits) colors
    
    static let bunchOfSChoices = [
        UIColor(named: "ColorSelection1"),
        UIColor(named: "ColorSelection2"),
        UIColor(named: "ColorSelection3"),
        UIColor(named: "ColorSelection4"),
        UIColor(named: "ColorSelection5"),
        UIColor(named: "ColorSelection6"),
        UIColor(named: "ColorSelection7"),
        UIColor(named: "ColorSelection8"),
        UIColor(named: "ColorSelection9"),
        UIColor(named: "ColorSelection10"),
        UIColor(named: "ColorSelection11"),
        UIColor(named: "ColorSelection12"),
        UIColor(named: "ColorSelection13"),
        UIColor(named: "ColorSelection14"),
        UIColor(named: "ColorSelection15"),
        UIColor(named: "ColorSelection16"),
        UIColor(named: "ColorSelection17"),
        UIColor(named: "ColorSelection18")
    ]
    
    static let gradient = [
        UIColor(named: "gBlue")!,
        UIColor(named: "gGreen")!,
        UIColor(named: "gRed")!,
    ]
}
// MARK: - For StatisticViewController - Gradient
extension UIView {
     private static let kLayerNameGradientBorder = "GradientBorderLayer"

     func gradientBorder(
         width: CGFloat,
         colors: [UIColor],
         startPoint: CGPoint = .init(x: 0.5, y: 0),
         endPoint: CGPoint = .init(x: 0.5, y: 1),
         andRoundCornersWithRadius cornerRadius: CGFloat = 0
     ) {
         let existingBorder = gradientBorderLayer()
         let border = existingBorder ?? .init()
         border.frame = CGRect(
             x: bounds.origin.x,
             y: bounds.origin.y,
             width: bounds.size.width + width,
             height: bounds.size.height + width
         )
         border.colors = colors.map { $0.cgColor }
         border.startPoint = startPoint
         border.endPoint = endPoint

         let mask = CAShapeLayer()
         let maskRect = CGRect(
             x: bounds.origin.x + width/2,
             y: bounds.origin.y + width/2,
             width: bounds.size.width - width,
             height: bounds.size.height - width
         )
         mask.path = UIBezierPath(
             roundedRect: maskRect,
             cornerRadius: cornerRadius
         ).cgPath
         mask.fillColor = UIColor.clear.cgColor
         mask.strokeColor = UIColor.white.cgColor
         mask.lineWidth = width

         border.mask = mask

         let isAlreadyAdded = (existingBorder != nil)
         if !isAlreadyAdded {
             layer.addSublayer(border)
         }
     }

     private func gradientBorderLayer() -> CAGradientLayer? {
         let borderLayers = layer.sublayers?.filter {
             $0.name == UIView.kLayerNameGradientBorder
         }
         if borderLayers?.count ?? 0 > 1 {
             fatalError()
         }
         return borderLayers?.first as? CAGradientLayer
     }
 }

extension CGPoint {

     enum CoordinateSide {
         case topLeft, top, topRight, right, bottomRight, bottom, bottomLeft, left
     }

     static func unitCoordinate(_ side: CoordinateSide) -> CGPoint {
         let x: CGFloat
         let y: CGFloat

         switch side {
         case .topLeft:      x = 0.0; y = 0.0
         case .top:          x = 0.5; y = 0.0
         case .topRight:     x = 1.0; y = 0.0
         case .right:        x = 0.0; y = 0.5
         case .bottomRight:  x = 1.0; y = 1.0
         case .bottom:       x = 0.5; y = 1.0
         case .bottomLeft:   x = 0.0; y = 1.0
         case .left:         x = 1.0; y = 0.5
         }
         return .init(x: x, y: y)
     }
 }
