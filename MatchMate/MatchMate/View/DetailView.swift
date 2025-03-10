//
//  DetailView.swift
//  MatchMate
//
//  Created by Aakash Narkar on 09/03/25.
//

import SwiftUI

struct DetailView: View {
    @Binding var match: Match
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(alignment: .leading) {
                HeaderView(isBackNavigationVisible: true, show: $show)
                CardAysncImageView(viewModel: AsyncImageViewModel(imageAssest: match.image ?? ""))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .scaledToFill()
                    .matchedGeometryEffect(id: match.image ?? "", in: namespace)
                    .background(Color(red: 236/255, green: 102/255, blue: 101/255))
                
                Text(match.fullName ?? "")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.leading)
                
                Text(match.address ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Spacer()
                if let isAccepted = match.isAccepted {
                    VStack(spacing: 8) {
                        Divider()
                            .background(.white)
                            .padding(.horizontal)
                        
                        Text(isAccepted ? AppConstant.accepted : AppConstant.declined)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .transition(.opacity.combined(with: .scale))
                            .padding(.bottom)
                    }
                    .background(isAccepted ? .green : .red)
                }
            }
        }
        .background(ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    DetailView(match: .constant(Match(fullName: "John Doe", address: "1234 Elm St", image: "https://example.com/image.jpg", isAccepted: true)),
               namespace: Namespace().wrappedValue,
               show: .constant(true))
}
