//
//  MatchCardDescription.swift
//  MatchMate
//
//  Created by Aakash Narkar on 08/03/25.
//

import SwiftUI

struct MatchCardDescription: View {
    @Binding var match: Match
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: match.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .shadow(radius: 5)
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(match.fullName ?? "")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    
                    Text(match.address ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    if let isAccepted = match.isAccepted {
                        VStack(spacing: 8) {
                            Rectangle()
                                .frame(height: 12)
                                .opacity(0)
                            
                            Divider()
                                .background(.white)
                                .padding(.horizontal)
                            
                            Text(isAccepted ? "Accepted" : "Declined")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(isAccepted ? .green : .red)
                                .padding()
                                .background(.clear)
                                .transition(.opacity.combined(with: .scale))
                                .padding(.bottom)
                        }
                    } else {
                        MatchCardBottomView(match: $match)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                )
            }
        }
        .animation(.easeInOut, value: match.isAccepted)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    let sampleMatch = Match(fullName: "Abc")
    return MatchCardDescription(match: .constant(sampleMatch))
}
