//  Created by Scot Curry on 8/5/23.
//

import SwiftUI
import DatadogLogs
// import DatadogCore

struct LeagueSelectionView: View {
    
    let leagueList: [LeagueList]
    
    var body: some View {
        NavigationStack {
            List(leagueList, id: \.id ) { currentLeague in
                NavigationLink(destination: Text(currentLeague.leagueDisplayName)) {
                    Label(currentLeague.leagueDisplayName, systemImage: "person.3")
                        .labelStyle(.titleAndIcon)
                }
            }
            Button("Button", action: {
                LoggingHandler.createLogEntry(message: "Button Tapped")
            })
            NavigationLink("Database View") {
                DatabaseAPIView()
                    .padding()
            }
            .navigationTitle("Fantasy Teams")
        }
        .trackRUMView(name: "LeagueSelectionView")
        .task {
            await pullGameInfo()
        }
    }
}

struct LeagueSelectionView_Previews: PreviewProvider {
    
    static var leagueList = LeagueList.leagueData
    
    static var previews: some View {
        LeagueSelectionView(leagueList: leagueList)
    }
}


private func pullGameInfo() async -> String {
    // Make sure we don't get a nil value when creating the URL.
    guard let url = URL(string: "https://ubuntu-microk8s.curryware.org/java/game_info/get_game_info", encodingInvalidCharacters: true) else {
        return "Scot"
    }
//    let downloadTask = URLSession.shared.downloadTask(with: url) { localUrl, urlResponse, error in
//        if let localUrl = localUrl {
//            if let data = try? Data(contentsOf: localUrl) {
//                print(String(data: data, encoding: .utf8) ?? "No Data")
//            }
//        }
//    }
//    downloadTask.resume()
    
    do
    {
        let (data, response) = try await URLSession.shared.data(from: url)
        let valid_range = 200..<300
        guard let httpResponse = response as? HTTPURLResponse, valid_range.contains(httpResponse.statusCode) else {
            print("Invalid HTTP status code")
            return "Scot"
        }
        let gameInfo = try JSONDecoder().decode([GameInfo].self, from: data)
        print(String(data: data, encoding: .utf8) ?? "No Data")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    return "Scot"
}
