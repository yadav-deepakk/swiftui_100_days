//
//  HabitDetailsView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 02/11/26.
//

import SwiftUI

struct HabitDetailsView: View {
    var habits: Habits
    var uuid: UUID
    
    var habit: Habit? { habits.habitList.filter{ $0.id == uuid }.first }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if let habit = habit {

            Form {
                Section("habit".capitalized) {
                    Text("\(habit.title)")
                        .font(.headline.bold())
                    Text("\(habit.details)")
                        .font(.subheadline)
                }
                Section("Did you complete it?") {
                    Stepper(
                        label: { Text("\(habit.count)") },
                        onIncrement: { modifyCount(operation: "inc") },
                        onDecrement: { modifyCount(operation: "dec") }
                    )
                }
                Section {
                    HStack { Button("Back",systemImage: "chevron.left") { dismiss() } }
                }
            }
        }
    }
    
    func modifyCount(operation: String) {
        guard let index = habits.habitList.firstIndex( where: { $0.id == uuid } ) else { return }
        if operation == "inc" {
            habits.habitList[index].count += 1
        } else {
            guard habits.habitList[index].count > 0 else { return }
            habits.habitList[index].count -= 1
        }
    }
}

#Preview {
    let habits: Habits = Habits()
    let uuid: UUID = UUID()
    HabitDetailsView(habits: habits, uuid: uuid)
}
