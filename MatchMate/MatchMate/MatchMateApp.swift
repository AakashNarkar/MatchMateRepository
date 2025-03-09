//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

@main
struct MatchMateApp: App {
    @State private var showSplash = true
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = MatchViewModel(networkManager: NetworkManager())
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            showSplash = false
                        }
                    }
            } else {
                ContentView(viewModel: viewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .onAppear {
                        InternetManager.shared.startNetworkReachabilityObserver()
                    }
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                viewModel.saveContent()
            case .inactive:
                viewModel.saveContent()
            default:
                break
            }
        }
    }
}
