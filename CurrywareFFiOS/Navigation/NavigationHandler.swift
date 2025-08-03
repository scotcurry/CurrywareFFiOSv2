//
//  NavigationHandler.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 5/28/25.
//

import SwiftUI
import DatadogCore

struct NavigationHandler: View {
    
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
    
    // let leagueList = LeagueList.leagueData
    let leagueSettings = LeagueSetting.sampleData
    @State private var showAlert: Bool = true
    var gdprTracking: String = "pending"
    
    var body: some View {
        
        NavigationStack {
            Spacer()
            NavigationLink {
                LeagueSelectorView()
            } label: {
                HStack {
                    Image(systemName: "person.2.circle.fill")
                        //.foregroundColor(.blue)
                        .aspectRatio(contentMode: .fit)
                        .imageScale(.large)
                    Text("Players")
                        .font(.title)
                        .fontDesign(.rounded)
                    Spacer()
                }
                .padding(60)
                
            }
            Spacer()
            NavigationLink {
                LeagueSelectorView()
            } label: {
                Text("League")
                    .font(.title)
                    .fontDesign(.rounded)
            }
            Spacer()
            NavigationLink {
                PlayerInfoView()
            } label: {
                Text("Player Info")
                    .font(.title)
                    .fontDesign(.rounded)
            }
            
            .navigationTitle("Options")
        }
        
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

#Preview {
    NavigationHandler()
}
