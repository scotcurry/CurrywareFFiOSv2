//  Created by Scot Curry on 8/5/23.
//

import SwiftUI
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
            NavigationLink("Database View") {
                DatabaseAPIView()
                    .padding()
            }
            .navigationTitle("Fantasy Teams")
        }
        .trackRUMView(name: "LeagueSelectionView")
    }
}

struct LeagueSelectionView_Previews: PreviewProvider {
    
    static var leagueList = LeagueList.leagueData
    
    static var previews: some View {
        LeagueSelectionView(leagueList: leagueList)
    }
}
