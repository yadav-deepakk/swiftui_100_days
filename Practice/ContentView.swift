//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct CustomText: View {
    var number: Int
    
    var body : some View {
        Text("showing view \(number)")
    }
    
    init(number: Int) {
        print("number \(number) is initialized")
        self.number = number
    }
}

struct ContentView : View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1..<100) { i in
                    NavigationLink {
                        CustomText(number: i)
                    } label: {
                        Text("Tap Me \(i)")
                    }
                }
            }
            .navigationTitle("Navigation Stack")

        }
    }
}

#Preview {
    ContentView()
}
