//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
}

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
                items = decoded
            } else {
                items = []
            }
        }
    }
}

struct ContentView: View {
    @State private var expensesList: Expenses = Expenses()
    var body: some View {
        NavigationStack {
            List {
                ForEach(expensesList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)").font(.title3.weight(.semibold))
                            Text("\(item.type.capitalized)").font(.caption)
                        }
                        Spacer()
                        Text("\(item.amount.formatted())").font(.title3.bold())
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddItemView(expenses: expensesList)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        
    }

    func removeItem(at offsets: IndexSet) {
        expensesList.items.remove(atOffsets: offsets)
    }

}

#Preview {
    ContentView()
}
