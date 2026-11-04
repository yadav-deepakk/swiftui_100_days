//
//  CheckoutView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 03/11/26.
//

import SwiftUI

enum NetworkError: Error {
    case invalidURL, invalidResponse, noData, badResponse(Int)
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
            .alert("Order Update", isPresented: $showingConfirmation) { Button("OK") { } }
            message: { Text("\(confirmationMessage)") }
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
            guard let http = response as? HTTPURLResponse else { throw  NetworkError.invalidResponse }
            guard (200...299).contains(http.statusCode) else { throw NetworkError.badResponse(http.statusCode) }
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decoded.quantity)x \(Order.types[decoded.type]) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch NetworkError.invalidResponse {
            print("Error: The server response was not a valid HTTP response.")
            confirmationMessage = "Unexpected response from the server."
            showingConfirmation = true

        } catch NetworkError.badResponse(let statusCode) {
            print("Error: Server returned status code \(statusCode).")
            confirmationMessage = "The server returned an error (\(statusCode)). Please try again."
            showingConfirmation = true

        } catch let error as URLError {
            // Network-level problems: offline, timeout, can't reach localhost, etc.
            confirmationMessage = switch error.code {
                case .notConnectedToInternet: "You appear to be offline."
                case .timedOut: "The request timed out. Please try again."
                case .cannotConnectToHost, .cannotFindHost: "Couldn't reach the server."
                default: "Network error: \(error.localizedDescription)"
            }
            print("URLError: \(error.code) - \(error.localizedDescription)")
            showingConfirmation = true

        } catch let error as EncodingError {
            print("Encoding error: \(error)")
            confirmationMessage = "Couldn't prepare your order."
            showingConfirmation = true

        } catch let error as DecodingError {
            print("Decoding error: \(error)")
            confirmationMessage = "Couldn't read the server's response."
            showingConfirmation = true

        } catch {
            // Catch-all for anything unexpected
            print("Unexpected error: \(error.localizedDescription)")
            confirmationMessage = "Something went wrong. Please try again."
            showingConfirmation = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
