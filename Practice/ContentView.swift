//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var city: String
    var street: String
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Click") {
                let user = """
                    {
                        "name": "Jason Roy",
                        "address": {
                            "street": "street no. 1",
                            "city": "new york city"
                        }
                    }
                    """
                let data = Data(user.utf8)
                if let decoded = try? JSONDecoder().decode(User.self, from: data) {
                    let city = decoded.address.city
                    print(city)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
