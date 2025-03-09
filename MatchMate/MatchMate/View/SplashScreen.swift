//
//  SpashScreen.swift
//  MatchMate
//
//  Created by Aakash Narkar on 09/03/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color(red: 236/255, green: 102/255, blue: 101/255).edgesIgnoringSafeArea(.all) // Background color
            
            VStack {
                Image(systemName: "star.fill") // Replace with your logo
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                Text("MatchMate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .opacity(isActive ? 1 : 0) // Fade-in effect
            .animation(.easeIn(duration: 1.0), value: isActive)
        }
        .onAppear {
            isActive = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}


#Preview {
    SplashScreen()
}
