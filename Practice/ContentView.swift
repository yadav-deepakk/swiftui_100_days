//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct ContentView : View {
    @State private var count = 0
    var body: some View {
        Button("Tap Count: \(count)", action: { count += 1 })
//            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: count)
            .sensoryFeedback(.impact(weight: .heavy, intensity: 0.5), trigger: count)
    }
}

#Preview {
    ContentView()
}
