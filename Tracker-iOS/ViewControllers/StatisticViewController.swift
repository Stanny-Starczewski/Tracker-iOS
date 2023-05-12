import UIKit

 final class StatisticViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .WhiteDay
     }
 }
// MARK: - SHOW PREVIEW

import SwiftUI
struct CreateStatisticVCProvider: PreviewProvider {
    static var previews: some View {
        StatisticViewController().showPreview()
    }
}
