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
                let newMatches = self.getMatches(results)
                newMatches.forEach { self.matches.append($0) }
                self.page += 1
            }
        }
    }
    
    func getMatches(_ results: [Result]) -> [Match] {
        let matches = results.map { response in
            Match(
                value: response.id?.value ?? "",
                fullName: "\(response.name?.first ?? "") \(response.name?.last ?? "")",
                address: """
                \(response.location?.street?.number ?? 0) \(response.location?.street?.name ?? ""), \
                \(response.location?.city ?? ""), \(response.location?.state ?? ""), \(response.location?.country ?? "")
                """,
                image: response.picture?.large ?? ""
            )
        }
        return matches
    }
}
