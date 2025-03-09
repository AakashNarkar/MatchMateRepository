//
//  ContentView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: MatchViewModel
    @State var showNavigation: Bool = false
    @State var selected: Match = Match(fullName: "", image: "")
    @Namespace private var namespace
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HeaderView(isBackNavigationVisible: showNavigation, show: $showNavigation)
                List {
                    ForEach($viewModel.matches, id: \.identifier) { match in
                        MatchCardView(match: match)
                            .listRowSeparator(.hidden) // Hide the divider
                            .listRowBackground(Color.clear)
                            .onAppear {
                                if match.wrappedValue == viewModel.matches.last {
                                    viewModel.fetchMatches()
                                }
                            }
                            .padding(.vertical)
                            .transition(.scale(scale: 0.5, anchor: .center))
                            .onTapGesture {
                                showNavigation.toggle()
                                selected = match.wrappedValue
                            }
                    }
                    
//                     Show loader at the end of the list
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView(viewModel.matches.isEmpty ? AppConstant.loadingString : AppConstant.loadingMoreString)
                            Spacer()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
            }
            .background(.gray.opacity(0.05))
            .onReceive(NotificationCenter.default.publisher(for: .networkDidChange), perform: { object in
                if let status = object.object as? String, status == AppConstant.online {
                    viewModel.fetchMatches()
                }
            })
            .onAppear {
                viewModel.getSavedContent()
            }
            
            if showNavigation {
                DetailView(match: $selected, namespace: namespace, show: $showNavigation)
                    .matchedGeometryEffect(id: $selected.wrappedValue.identifier, in: namespace)
                    .transition(.scale(scale: 0.5, anchor: .center))
                    .opacity(showNavigation ? 1 : 0)
            }
        }
    }
}

#Preview {
    ContentView(viewModel: MatchViewModel(networkManager: NetworkManager())).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
