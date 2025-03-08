//
//  MatchViewModel.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

class MatchViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var isLoading = false  // Added loader state
    private let apiURL = AppConstant.apiURL
    private var page = 1
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMatches() {
        guard !isLoading else { return }
        isLoading = true
        let urlString = "\(apiURL)?results=10&page=\(page)"
        
        networkManager.fetchRequest(urlString: urlString) { [weak self] (response: APIResponse?, error: Error?) in
            guard let self = self else { return }
            self.isLoading = false
            if let results = response?.results {
                self.matches.append(contentsOf: results.map { Match(from: $0) })
                self.page += 1
            }
        }
    }
    
    func updateMatch(_ match: Match, status: String) {
        if let index = matches.firstIndex(where: { $0.id == match.id }) {
            matches[index].status = status
        }
    }
}
