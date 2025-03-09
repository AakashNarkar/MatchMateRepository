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
    @State var selected: Match = Match(fullName: "", image: "")
    @State var showNavigation: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HeaderView()
                List {
                    ForEach(viewModel.matches, id: \.identifier) { match in
                        MatchCardView(match: Binding.constant(match))
                            .onAppear {
                                if match == viewModel.matches.last {
                                    viewModel.fetchMatches()
                                }
                            }
                            .padding(.vertical)
                            .transition(.scale(scale: 0.5, anchor: .center))
                            .onTapGesture {
                                showNavigation.toggle()
                                selected = match
                            }
                            .matchedGeometryEffect(id: match.identifier, in: namespace)
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
            }
            .background(.gray.opacity(0.05))
            .onReceive(NotificationCenter.default.publisher(for: .networkDidChange), perform: { object in
                if let status = object.object as? String, status == "online" {
//                    self.getData()
                }
            })
            .onAppear {
                viewModel.fetchMatches()
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
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
