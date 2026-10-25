//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct CustomText: View {
    var text : String
    var body : some View {
        Text("\(text)")
            .font(.title.weight(.semibold))
    }
    init(text: String) {
        print("creating custom text: \(text)")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach (1..<100) {
                    CustomText(text: "List item \($0)")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
