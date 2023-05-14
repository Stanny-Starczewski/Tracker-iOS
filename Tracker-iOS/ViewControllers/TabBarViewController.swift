import UIKit

class TabBarViewController: UITabBarController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .Blue
        tabBar.barTintColor = .Gray
        tabBar.backgroundColor = .WhiteDay
        
        tabBar.layer.borderColor = UIColor.LightGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let trackersViewController = TrackersViewController()
        let statisticViewController = StatisticViewController()
        
        trackersViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "Trackers_TabBarIcon_on"),
            selectedImage: nil
        )
        statisticViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
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
