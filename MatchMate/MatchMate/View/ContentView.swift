//
//  ContentView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewModel = MatchViewModel(networkManager: NetworkManager())
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.matches) { match in
                        MatchCardView(match: match, viewModel: viewModel)
                            .onAppear {
                                if match == viewModel.matches.last {
                                    viewModel.fetchMatches()
                                }
                            }
                    }
                    
                    // Show loader at the end of the list
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView(viewModel.matches.isEmpty ? AppConstant.loadingString : AppConstant.loadingMoreString)
                            Spacer()
                        }
                    }
                }
                .navigationTitle(AppConstant.navigationTitle)
                .onAppear {
                    viewModel.fetchMatches()
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
