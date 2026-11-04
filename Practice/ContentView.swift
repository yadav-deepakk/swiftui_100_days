//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct PushButton: View {
    var title: String
    @Binding var isOn: Bool
    
    var onColor = [Color.teal, Color.green]
    var offColor = [Color(white:0.60), Color(white: 0.40)]
    
    var body: some View {
        Button(title) { isOn.toggle() }
            .font(.title3.bold())
            .padding(18)
            .background(LinearGradient(colors: isOn ? onColor : offColor, startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(Capsule())
            .foregroundStyle(.white)
    }
}

struct ContentView : View {
    @State private var rememberMe: Bool = false
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "ON" : "OFF")
        }
    }
}

#Preview {
    ContentView()
}
