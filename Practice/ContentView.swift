//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct ContentView : View {
    @State private var path: [Int] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to 32") {
                    path = [32]
                }
                
                Button("Go to 64") {
                    path = [32]
                }
                
                Button("Go to 32 then 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("Screen \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}
