//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import Observation
import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "taylor"
}

struct ContentView : View {
    
    var body: some View {
        VStack {
            Button("encode", action: encodeUser)
        }
    }
    
    func encodeUser() {
        let encode = try! JSONEncoder().encode(User())
        let str = String(decoding: encode, as: UTF8.self)
        print(str)
    }
    
}

#Preview {
    ContentView()
}
