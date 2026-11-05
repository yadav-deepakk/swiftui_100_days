//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftData
import SwiftUI

struct ContentView : View {
    
    @Environment(\.modelContext) var modelCtx
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Students")
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        let firstNames: [String] = ["Deepak", "Roneel", "Keyur", "Naman"]
                        let lastNames: [String] = ["Yadav", "Govekar", "Togadia", "Gulati"]
                        
                        let first = firstNames.randomElement() ?? "Unknown"
                        let last = lastNames.randomElement() ?? "student"
                        let student = Student(name: "\(first) \(last)")
                        
                        modelCtx.insert(student)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
