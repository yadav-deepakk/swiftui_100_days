//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct ContentView : View {
    var students: [Student] = [
        Student(name: "Sandeep", age: 22),
        Student(name: "Viky", age: 26),
        Student(name: "Ranveer", age: 32),
    ]
    var body: some View {
        NavigationStack {
            List {
                ForEach(students.indices, id:\.self) { i in
                    NavigationLink("go to \(i)", value: students[i])
                }
            }
            .navigationDestination(for: Student.self) { student in
                Text("Hello Student \(student.name)")
            }
            .navigationTitle("Navigation Stack")

        }
    }
}

#Preview {
    ContentView()
}
