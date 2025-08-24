//  Created by Scot Curry on 8/5/23.
//

import SwiftUI
import DatadogCore

struct LeagueSelectionView: View {
    
    // This is interesting code.  It is used to set the alter below.  @AppStorage
    // (https://developer.apple.com/documentation/swiftui/appstorage) pulls values
    // from UserDefaults.  It also, INVALIDATES the view if the value changes.  This
    // means that the application always starts with a pending state.  The user changes
    // it and it will
    @AppStorage("gdrpAccepted") private var gdrpAccepted = "pending"
    private var shouldShowGDPRAlert: Bool {
        return gdrpAccepted == "pending"
    }
    
    private var alertBinding: Binding<Bool> {
        Binding(
            get: { self.shouldShowGDPRAlert},
            set: { newValue in
                self.gdrpAccepted = newValue ? "accepted" : "declined"
            }
        )
    }
    
    @StateObject var leagueSelectorViewModel = LeagueSelectorViewModel()
    @State private var selectedLeague: String?
    var gdprTracking: String = "pending"
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(leagueSelectorViewModel.items) { leagueInfo in
                    NavigationLink(leagueInfo.team_name!) {
                        InitialContent(league: leagueInfo)
                    }
                    .navigationTitle(leagueInfo.team_name!)
                }
            }
        }
        .trackRUMView(name: "LeagueSelectionView")
        .task {
            await leagueSelectorViewModel.fetchGameInfo()
        }
        .navigationTitle("Leagues")
        
        // This is where we put the initial message to have users accept GDRP.  This causes the
        // gdrpAccepted variable above to be updated which invalidates this view and causes it to
        // be redrawn.  At the same time, Datadog RUM is initialized.
        .alert("GDPR", isPresented: alertBinding) {
            Button("Allow Datadog") {
                UserDefaults.standard.set("granted", forKey: "gdrpAccepted")
                Datadog.set(trackingConsent: .granted)
                DatadogRumHandler.startDatadog()
            }
            Button("Cancel") {
                UserDefaults.standard.set("notGranted", forKey: "gdrpAccepted")
            }
        } message: {
            Text("Alert Message")
        }
    }
}

struct LeagueSelectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        let leagueSelectorViewModel = LeagueSelectorViewModel()
        LeagueSelectionView(leagueSelectorViewModel: leagueSelectorViewModel)
    }
}
