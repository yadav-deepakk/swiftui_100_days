//
//  AddBookView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 05/11/26.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = "Fantasy"
    @State private var review: String = ""
    @State private var rating: Int = 3
    
    let genreList = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Book details") {
                    TextField("book title".capitalized, text: $title)
                    TextField("book author".capitalized, text: $author)
                    Picker("Book genre".capitalized, selection: $genre) {
                        ForEach(genreList, id: \.self) { genreItem in
                            Text("\(genreItem)")
                        }
                    }
                }
                Section("Write a review") {
                    TextField("write a review about book here", text: $review, axis: .vertical)
                        .lineLimit(2...5)
                    RatingView(rating: $rating)
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Add") {
                            addBook()
                            dismiss()
                        }
                        Spacer()
                    }
                    .disabled(!isValidBookForm())
                }
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button { dismiss() } label: {
                    Text("Dismiss").font(.subheadline)
                }
            }
        }
        
    }
    
    func addBook() {
        let book = Book(title: title, author: author, genre: genre, review: review, rating: rating)
        modelContext.insert(book)
    }
    
    func isValidBookForm() -> Bool {
        func isValidGenre(_ genre: String) -> Bool {
            genreList.contains(genre)
        }
        func trimWhitespaceAndNewlines(_ string: String) -> Bool {
            !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        return trimWhitespaceAndNewlines(title) && trimWhitespaceAndNewlines(author) && isValidGenre(genre)
    }
}

#Preview {
    AddBookView()
}
