//
//  CheckoutView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 03/11/26.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        EmptyView()
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 240)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                Button("Place Order") { }
                    .padding()
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
