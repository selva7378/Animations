//
//  ContentView.swift
//  Animations
//
//  Created by Remitbee on 04/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        VStack {
            Button("Tap Me") {
//                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(.blue)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeOut(duration: 2)
                            .repeatForever(autoreverses: true),
                        value: animationAmount
                    )
            )
           
        }
        .padding()
        .onAppear{
            animationAmount = 2
        }
    }
}

#Preview {
    ContentView()
}
