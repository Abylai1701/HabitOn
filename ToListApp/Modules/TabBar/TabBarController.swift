import Foundation

import UIKit

final class TabbarController: UITabBarController,
                                UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let main = MainController()
        main.tabBarItem = UITabBarItem.init(title: "main".localized, image: UIImage(named: "Home"), tag: 0)
        
        let deadlines = DeadlinesViewController()
        deadlines.tabBarItem = UITabBarItem.init(title: "deadlines".localized, image: #imageLiteral(resourceName: "Notification"), tag: 1)
        
        let settings = SettingsViewController()
        settings.tabBarItem = UITabBarItem.init(title: "settings".localized, image: #imageLiteral(resourceName: "Settings"), tag: 2)
        
        
        self.tabBar.tintColor = .main
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.backgroundColor = .blueColor
        UITabBar.appearance().barTintColor = .blueColor
        self.viewControllers = [main, deadlines, settings]
        
    }
}

