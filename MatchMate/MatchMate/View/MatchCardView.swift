//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

struct MatchCardView: View {
    @Binding var match: Match
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack(spacing: 16) {
            MatchCardDescription(match: $match)
        }
        .frame(width: UIScreen.main.bounds.width - 48, height: UIScreen.main.bounds.height / 2.8)
        .padding()
    }
}

#Preview {
    let sampleMatch = Match(fullName: "Abc")
    return MatchCardView(match: .constant(sampleMatch))
}
