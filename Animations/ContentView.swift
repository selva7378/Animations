//
//  ContentView.swift
//  Animations
//
//  Created by Remitbee on 04/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false

    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
    }
}

#Preview {
    ContentView()
}
