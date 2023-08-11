//  Created by Scot Curry on 8/6/23.
//

import UIKit
import OSLog
import DatadogCore
import DatadogRUM

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        DatadogRumHandler.startDatadog()
        
        return true
    }
}
