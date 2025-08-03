//  Created by Scot Curry on 8/5/23.
//

import SwiftUI
import DatadogLogs

struct LeagueSelectionView: View {
    
    @StateObject var leagueSelectorViewModel = LeagueSelectorViewModel()
    @State private var selectedLeague: String?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(leagueSelectorViewModel.items) { leagueInfo in
                    NavigationLink(leagueInfo.team_name!) {
                        InitialContent(league: leagueInfo)
                    }
                }
            }
        }
        .trackRUMView(name: "LeagueSelectionView")
        .task {
            await leagueSelectorViewModel.fetchGameInfo()
        }
    }
}

struct LeagueSelectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        let leagueSelectorViewModel = LeagueSelectorViewModel()
        LeagueSelectionView(leagueSelectorViewModel: leagueSelectorViewModel)
    }
}
