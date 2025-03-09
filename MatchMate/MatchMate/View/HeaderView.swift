//
//  HeaderView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

struct HeaderView: View {
    var isBackNavigationVisible: Bool
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: isBackNavigationVisible ? "chevron.left" : "star.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding(.leading)
                    .onTapGesture {
                        isBackNavigationVisible ? show.toggle() : nil
                    }
                VStack(alignment: .leading) {
                    Text(AppConstant.navigationTitle)
                        .font(.system(size: 24, weight: .heavy))
                        .padding(.vertical)
                }
                Spacer()
            }
            .background(Color(red: 236/255, green: 102/255, blue: 101/255))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    HeaderView(isBackNavigationVisible: true, show: .constant(true))
}
