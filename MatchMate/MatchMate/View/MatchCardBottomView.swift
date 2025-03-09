//
//  MatchCardBottomView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

struct MatchCardBottomView: View {
    @Binding var match: Match
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    withAnimation {
                        match.isAccepted = false
                    }
                }) {
                    Circle()
                        .fill()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.red)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
                Spacer()
                
                Button(action: {
                    withAnimation {
                        match.isAccepted = true
                    }
                }) {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.green)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
            }
        }
    }
}

#Preview {
    let sampleMatch = Match(fullName: "Abc")
    return MatchCardBottomView(match: .constant(sampleMatch))
}
