//
//  CheckoutView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 03/11/26.
//

import SwiftUI

enum NetworkError: Error {
    case invalidURL, noData, badResponse(Int), decodingFailure
}

struct CheckoutView: View {

    @Bindable var order: Order
    
    @State private var showingConfirmation: Bool = false
    @State private var confirmationMessage: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if let err = phase.error {
                        EmptyView().onAppear { print(err) }
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 240)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .padding(.bottom, 10)
                Button("Place Order") {
                    Task { await placeOrder() }
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Order Update", isPresented: $showingConfirmation) {
                Button("OK") { }
            } message: {
                Text("\(confirmationMessage)")
            }
        }
    }
    
    func placeOrder() async {
        do {
            let url = URL(string: "http://localhost:8080/api/v1/cupcakes")!
            var req = URLRequest(url: url)
            req.setValue("appication/json", forHTTPHeaderField: "Content-Type")
            req.httpMethod = "POST"
            req.httpBody = try JSONEncoder().encode(order)
            let (data, response) = try await URLSession.shared.data(for: req)
            guard let http = response as? HTTPURLResponse else { throw  NetworkError.decodingFailure }
            guard (200...299).contains(http.statusCode) else { throw NetworkError.badResponse(http.statusCode) }
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decoded.quantity)x \(Order.types[decoded.type]) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
