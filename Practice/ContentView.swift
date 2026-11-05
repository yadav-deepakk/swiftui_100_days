//
//  ContentView.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 04/09/26.
//

import SwiftUI
import SwiftData

struct ContentView : View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showAddBook: Bool = false
    
    var body: some View {
        NavigationStack {
            booksListView()
                .sheet(isPresented: $showAddBook) { AddBookView() }
                .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self) { book in
                    BookDetailView(book: book)
                }
                .toolbar {
                    if !books.isEmpty {
                        ToolbarItem { EditButton() }
                    }
                    ToolbarItem {
                        Button { showAddBook.toggle() } label: { Image(systemName: "plus") }
                    }
                }
        }
    }
    
    @ViewBuilder
    func image(_ rating: Int) -> some View {
        let emoticonList = [ "☹️", "🙁", "😐", "😃", "😍"]
        if rating <= 5 && rating>0 {
            Text("\(emoticonList[rating-1])")
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func booksListView() -> some View {
        if books.isEmpty {
            Spacer()
            Button { showAddBook.toggle() } label: {
                VStack {
                    Image(systemName: "book.badge.plus")
                        .font(.largeTitle)
                    Text("Book list is empty")
                    Text("Please try adding one!")
                }
            }
            Spacer()
            Spacer()
            Spacer()
        } else {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        image(book.rating)
                            .font(.title)
                            .padding(.trailing, 10)
                        VStack(alignment: .leading) {
                            Text(book.title).font(.headline.bold())
                            Text(book.author).font(.caption)
                        }
                    }
                }
                .onDelete(perform: removeBookItem)
            }
        }
    }
    
    func removeBookItem(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(books[index])
        }
    }
}

#Preview {
    ContentView()
}
