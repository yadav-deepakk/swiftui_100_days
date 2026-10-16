//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

@Observable
class User {
    var firstName: String
    var lastName: String
    init() {
        self.firstName = ""
        self.lastName = ""
    }
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct ContentView: View {
    @State var user: User = User()
    var body: some View {
        VStack {
            Text("Your name is : \(user.firstName) \(user.lastName)")
            Form {
                TextField("Enter first name:", text: $user.firstName)
                TextField("Enter last name:", text: $user.lastName)
            }
        }
    }
}

#Preview {
    ContentView()
}
