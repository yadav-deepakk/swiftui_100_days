//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1..<100) { row in
                    NavigationLink {
                        Text("Details View \(row)")
                    } label: {
                        Text("Navigation Link \(row)")
                    }
                }
            }
            .navigationTitle("MoonShot")
        }
    }
}

#Preview {
    ContentView()
}
