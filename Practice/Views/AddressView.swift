//
//  AddressView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 03/11/26.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Enter name", text: $order.name)
                TextField("Enter Street address", text: $order.street)
                TextField("Enter City", text: $order.city)
                TextField("Enter Zip", text: $order.zip)
            }
            Section {
                NavigationLink("Checkout", destination: CheckoutView(order: order))
                    .disabled(!order.isValidAddress)
            }
        }
        .navigationTitle("Address Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
