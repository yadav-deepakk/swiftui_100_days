//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct DetailsView : View {
    @Binding var path: NavigationPath
    var number: Int
    var body: some View {
        NavigationLink("showing number: \(number)", value: Int.random(in: 1...1000))
            .navigationDestination(for: Int.self) { selection in
                DetailsView(path: $path, number: selection)
            }
            .navigationTitle("navigation \(number)")
            .toolbar{
                if path != NavigationPath() {
                    Button(
                        action: {self.path=NavigationPath()},
                        label:{Image(systemName: "house")}
                    )
                }
            }
    }
}

struct ContentView : View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            DetailsView(path: $path, number: 0)
        }
    }
}

#Preview {
    ContentView()
}
