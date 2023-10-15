import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppCenter.shared.createWindow(UIWindow(frame: UIScreen.main.bounds))
        UserManager.shared.setAccessToken(token: "JnwgrbiOvdDqkpd7XbAVj9jN3hR5EsmZnDomhJ8z")
        AppCenter.shared.start()
        return true
    }


}

