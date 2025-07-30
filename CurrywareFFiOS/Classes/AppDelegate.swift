//  Created by Scot Curry on 8/6/23.
//

import UIKit
import OSLog
import DatadogCore
import DatadogRUM

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // This gets set up in the main (CurrywareFFiOSApp) struct.  This is to handle lifecycle calls.  This sets up the Datadog agent.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        DatadogRumHandler.startDatadog()
        DatadogRumHandler.startLogging()
        return true
    }
}
