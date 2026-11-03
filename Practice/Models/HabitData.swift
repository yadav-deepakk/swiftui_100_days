//
//  HabitData.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 01/11/26.
//
import Foundation
import Observation

struct Habit: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var details: String
    var count: Int
}

@Observable
class Habits {
    var habitList: [Habit] = [] { didSet { self.save() } }
    init() { self.load() }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(habitList) {
            UserDefaults.standard.set(encoded, forKey: "HabitList")
        } else {
            print("unable to encode and save the habit list")
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "HabitList") {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
                habitList = decoded
                return
            }
        }
        print("unable to load the habit list from userdefaults")
        habitList = []
    }

}
