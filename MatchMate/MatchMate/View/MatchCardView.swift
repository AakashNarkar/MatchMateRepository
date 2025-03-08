//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

struct MatchCardView: View {
    let match: Match
    @ObservedObject var viewModel: MatchViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: match.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .cornerRadius(10)
            
            Text("\(match.name), \(match.age)")
                .font(.headline)
                .padding(.top, 5)
            
            HStack {
                Button("Accept") {
                    viewModel.updateMatch(match, status: "Accepted")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Decline") {
                    viewModel.updateMatch(match, status: "Declined")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

#Preview {
    MatchCardView(match: Match(from: User(name: Name(first: "ABC", last: "XYZ"), dob: DOB(age: 18), picture: Picture(large: "abc"))),
                  viewModel: MatchViewModel(networkManager: NetworkManager()))
}

