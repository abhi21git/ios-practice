import UIKit
import IOSPracticeKit
import IOSPracticeUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = HomeTabBarController()
        window?.rootViewController = viewController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }

}
