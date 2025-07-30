//
//  PlayerInfo.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 7/12/25.
//

import Foundation

@MainActor
class PlayerInfoList: ObservableObject {
    
    @Published private(set) var playerInfoList: [PlayerInfo] = []
    
    func getPlayerInfoList() async throws -> [PlayerInfo] {
        
        LoggingHandler.createLogEntry(message: "Starting getPlayerInfoList")
        let urlString = "https://ubuntu-microk8s.curryware.org/java/players/getplayers"
        if let playerURL = URL(string: urlString) {
            var request = URLRequest(url: playerURL)
            request.httpMethod = "GET"
            let (data, response) = try await URLSession.shared.data(for: request)
            let validRange = 200..<300
            guard let httpResponse = response as? HTTPURLResponse, validRange.contains(httpResponse.statusCode) else {
                LoggingHandler.createLogEntry(message: "Failed to get player info list")
                return playerInfoList
            }
            let decoder = JSONDecoder()
            let playerInfoListData = try! decoder.decode([PlayerInfo].self, from: data)
            self.playerInfoList = playerInfoListData
        }
        return playerInfoList
    }
}
