//
//  ExpenseItemView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 22/10/26.
//

import SwiftUI

struct AddItemView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var name: String = "ItemName"
    @State private var type: String = "personal"
    @State private var amount: Double = 0

    var types: [String] = ["personal", "business"]

    var expenses: Expenses

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0.capitalized)
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: "INR"))
                        .keyboardType(.decimalPad)
                }
                Section {
                    HStack {
                        Spacer()
                        Button( "Add") {
                            addItem()
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    func addItem() {
        let item = ExpenseItem(name: name, type: type, amount: amount)
        expenses.items.append(item)
    }

}

#Preview {
    AddItemView(expenses: Expenses())
}
