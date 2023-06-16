import UIKit

class TabBarViewController: UITabBarController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "visitedBefore")
        
        tabBar.tintColor = .ypBlue
        tabBar.barTintColor = .ypGray
        tabBar.backgroundColor = .ypWhiteDay
        
        tabBar.layer.borderColor = UIColor.ypLightGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let trackersViewController = TrackersViewController()
        let statisticViewController = StatisticViewController()
        
        trackersViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("TrackersViewController.title", comment: ""),
            image: UIImage(named: "Trackers_TabBarIcon_on"),
            selectedImage: nil
        )
        statisticViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("StatisticViewController.title", comment: ""),
            image: UIImage(named: "Statistics_TabBarIcon_off"),
            selectedImage: nil
        )
        
        let controllers = [trackersViewController, statisticViewController]
        
        viewControllers = controllers
    }
}
//// MARK: - SHOW PREVIEW
//
//import SwiftUI
//struct CreateTabBarVCProvider: PreviewProvider {
//    static var previews: some View {
//        TabBarViewController().showPreview()
//    }
//}
