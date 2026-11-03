//
//  AddHabitView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 01/11/26.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    var data: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Enter habit title", text: $title)
                }
                Section("Description") {
                    TextField("Enter description", text: $description, axis: .vertical)
                        .lineLimit(3...8)
                }
                HStack {
                    Spacer()
                    Button("Add", systemImage: "plus") {
                        let habit = Habit(title: title, details: description, count: 0)
                        data.habitList.append(habit)
                        dismiss()
                    }
                    .disabled(title.isEmpty || description.isEmpty || description.count <= 3)
                    Spacer()
                }
            }
            .toolbar{ Button("Dismiss") { dismiss() } }
            .navigationTitle("Add a habit")
        }
    }
}

#Preview {
    let habitData = Habits()
    AddHabitView(data: habitData)
}
