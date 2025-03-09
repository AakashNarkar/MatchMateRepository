//
//  HeaderView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(AppConstant.navigationTitle)
                        .font(.system(size: 24, weight: .heavy))
                        .padding(.vertical)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(Color(red: 236/255, green: 102/255, blue: 101/255))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    HeaderView()
}
