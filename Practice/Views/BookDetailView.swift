//
//  BookDetailView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 05/11/26.
//

import SwiftData
import SwiftUI

struct BookDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var book: Book
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image("\(book.genre)")
                    .resizable()
                    .scaledToFit()
                Text("\(book.genre)".uppercased())
                    .padding(8)
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .background(.black.opacity(0.5))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            VStack {
                Text(book.author.capitalized)
                    .font(.title)
                    .foregroundStyle(.secondary)
                Text(book.review).padding()
                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
            }
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItem {
                Button { showAlert.toggle() } label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                }
            }
        }
        .alert("Do you want to proceed", isPresented: $showAlert) {
            Button("Delete", role: .destructive) { deleteBook() }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This book `\(book.title)` by `\(book.author)` will be deleted from the list and you will not be able to recover it again.")
        }
    }
    
    func deleteBook() {
        modelContext.delete(self.book)
        dismiss()
    }
    
}

#Preview {
    let book = Book(title: "sample", author: "test author", genre: "Fantasy", review: "this is a book made for testing purpose only.", rating: 4)
    BookDetailView(book: book)
}
