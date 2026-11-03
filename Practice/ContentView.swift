//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//
import SwiftUI

struct ContentView : View {
    
    @State private var habits: Habits = Habits()
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.habitList) { item in
                    NavigationLink(value: item, label: {
                        HStack {
                            Image(systemName: "pencil.and.list.clipboard")
                                .font(.largeTitle)
                                .padding(.horizontal, 4)
                                .foregroundColor(.green)
                            VStack(alignment: .leading) {
                                Text("\(item.title)").font(.title3.bold())
                                Text("\(item.details)").font(.caption)
                                    .lineLimit(2)
                            }
                            Spacer()
                            Image(systemName: "flame.circle.fill")
                                .font(.title)
                                .foregroundColor(.pink)
                            Text("\(item.count)")
                                .font(.title.bold())
                        }
                    })
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("Habit Tracker")
            .navigationDestination(for: Habit.self) { habit in
                HabitDetailsView(habits: habits, uuid: habit.id)
            }
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem {
                    Button("Add", systemImage: "plus") {
                        showSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddHabitView(data: habits)
            }
        }
    }
    
    func removeItem(at offset: IndexSet) {
        habits.habitList.remove(atOffsets: offset)
    }
    
}

#Preview {
    ContentView()
}
