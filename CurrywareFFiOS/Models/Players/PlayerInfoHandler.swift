//
//  PlayerInfo.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 7/12/25.
//

import Foundation

@MainActor
class PlayerInfoHandler: ObservableObject {
    
    @Published private(set) var playerInfoList: [PlayerInfo] = []
    @Published var errorMessage: String?
    
    func getPlayerInfoList() async {
        
        print("Calling getPlayerInfoList")
        LoggingHandler.createLogEntry(message: "Starting getPlayerInfoList")
        // TODO: Handle error if there is ever an error condition.
        do {
        let urlString = BundleHandler.getPlayerInfoURL()
            if let playerURL = URL(string: urlString) {
                var request = URLRequest(url: playerURL)
                request.httpMethod = "GET"
                let (data, response) = try await URLSession.shared.data(for: request)
                let validRange = 200..<300
                guard let httpResponse = response as? HTTPURLResponse, validRange.contains(httpResponse.statusCode) else {
                    LoggingHandler.createLogEntry(message: "Failed to get player info list")
                    throw PlayerInfoError.invalidResponse
                }
                let decoder = JSONDecoder()
                playerInfoList = try! decoder.decode([PlayerInfo].self, from: data)
            }
        } catch PlayerInfoError.invalidResponse {
            LoggingHandler.createLogEntry(message: "Failed to get player info list: \(String(describing: errorMessage))")
        } catch {
            LoggingHandler.createLogEntry(message: "Unknown Exception: \(error)")
        }
    }
}

enum PlayerInfoError: Error {
    case invalidResponse
    case noDatabaseURL
}
