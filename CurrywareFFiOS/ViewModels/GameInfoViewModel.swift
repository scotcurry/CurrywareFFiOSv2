//
//  GameInfoViewModel.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 4/27/25.
//

import Foundation
import SwiftUI

@MainActor
class GameInfoViewModel: ObservableObject {
    
    @Published var items: [GameInfo] = []
    
    // It is important to note that you don't return anything in the ViewModel, you just set the published property.
    func fetchGameInfo() async {
        
        // Since the URL could return a nil value, this makes sure that it doesn't and continues on.  This is known as the
        // happy path since it doesn't bury the code we want to run if the value is good.
        guard let gameInfoUrl = URL(string: "https://ubuntu-microk8s.curryware.org/java/game_info/get_game_info") else {
            return
        }
        
        do {
            // URLRequest can take up to 3 parameters.  The URL is NOT an optional parameter, so it must be passed into the
            // intializaer.  Cachepolicy and timeoutInterval both have default values, so they don't need to be passed to
            // the initializer.
            var request = URLRequest(url: gameInfoUrl)
            // Set the values on the request components.
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = ["Content-Type": "application/json", "User-Agent": "Mozilla/5.0"]
            
            // There are two types of URLSession: 1) shared (used here), and 2) default.  To use default you need to create
            // a URLSessionConfiguration.
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Bad response from server")
            }
            items = try JSONDecoder().decode([GameInfo].self, from: data)
        } catch {
            print("Failed to fetch game info: \(error)")
            return
        }
    }
}

enum GameInfoError: Error {
    case invalidResponse
    case decodingFailed
    case invalidURL
}
