//  Created by Scot Curry on 8/5/23.
//

import Foundation

struct BundleHandler {
    
    static func getAppID() -> String {
        
        let appID = Bundle.main.infoDictionary?["APP_ID"] as? String
        if let appID = appID {
            print("AppID: \(appID)")
            return appID
        } else {
            return "No API Key"
        }
    }
    
    static func getClientToken() -> String {
        
        let clientToken = Bundle.main.infoDictionary?["CLIENT_TOKEN"] as? String
        if let clientToken = clientToken {
            return clientToken
        } else {
            return "No Client Token"
        }
    }
    
    static func getDatabaseAPIURL() -> String {
        
        let databaseURL = Bundle.main.infoDictionary?["DATABASE_URL"] as? String
        if let databaseURL = databaseURL {
            return databaseURL
        } else {
            return "No Database URL"
        }
    }
    
    static func getPlayerInfoURL() -> String {
        let playerInfoURL = Bundle.main.infoDictionary?["PLAYER_INFO_URL"] as? String
        if let playerInfoURL = playerInfoURL {
            return playerInfoURL
        } else {
            return "No Player Info URL"
        }
    }
}
