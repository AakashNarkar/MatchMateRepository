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
        HStack {
            Button(action: {
                withAnimation {
                    match.isAccepted = true
                }
            }) {
                Text(AppConstant.accept)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color(.green))
                    .cornerRadius(15, corners: .allCorners)
            }
            .buttonStyle(PlainButtonStyle()) // Disables List interference
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    match.isAccepted = false
                }
            }) {
                Text(AppConstant.decline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color(.red))
                    .cornerRadius(15, corners: .allCorners)
            }
            .buttonStyle(PlainButtonStyle()) // Disables List interference
        }
        .allowsHitTesting(true) // Ensures buttons capture taps
    }
}


#Preview {
    let sampleMatch = Match(fullName: "Abc")
    return MatchCardBottomView(match: .constant(sampleMatch))
}
