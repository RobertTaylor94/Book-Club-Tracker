//
//  BookCover.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct BookCoverView: View {
    
    let realm = try! Realm()
    
    @State var progressValue: Float = 0.01
    @State var bookID: String = ""
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookDescription: String = ""
    @State var bookImgUrl: String = ""
    @State var book: DBBook
    @State private var isShowingSheet = false
    
    
    var body: some View {
    
            VStack(spacing: 15) {
                
                Button(action: {
                    isShowingSheet.toggle()
                }, label: {
                    VStack(alignment: .leading, spacing: 16.0) {
                        if bookImgUrl != "" {
                            WebImage(url: URL(string: bookImgUrl)).resizable().frame(minWidth: 90, idealWidth: 120, maxWidth: .infinity, minHeight: 140, idealHeight: 170, maxHeight: 170).aspectRatio(contentMode: .fit).cornerRadius(10)
                        } else {
                            Image(systemName: "books.vertical").resizable().frame(minWidth: 90, idealWidth: 120, maxWidth: .infinity, minHeight: 140, idealHeight: 170, maxHeight: 170).cornerRadius(10)
                        }
                        Text("\(bookTitle)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(bookAuthor)")
                            .font(.caption)
                        Text("\(bookDescription)")
                            .fontWeight(.light)
                            .lineLimit(4)
                    }
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 200, minHeight: 175, idealHeight: 350, maxHeight: 350)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("BookTileColorOne"), Color("BookTileColorTwo")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)
                })
                .sheet(isPresented: $isShowingSheet) {
                    DetailView(progressValue: progressValue, bookID: bookID, bookTitle: bookTitle, bookAuthor: bookAuthor, bookDescription: bookDescription, bookImgUrl: bookImgUrl)
                }
                ProgressBar(progress: self.$progressValue)
                    .frame(minWidth: 50, idealWidth: 80, maxWidth: 100, minHeight: 50, idealHeight: 80, maxHeight: 100)
                    .padding()

                Stepper("", value: $progressValue, in: 0...1, step: 0.1)
                    .onChange(of: progressValue, perform: { value in
                        saveBook(book: book)
                    })

                
            
        }
    }
    
    func saveBook(book: DBBook) {
        do {
            try realm.write {
                book.progressValue = self.progressValue
            }
        } catch {
            print("Error saving context \(error)")
        }
    }

}


struct BookCover_Previews: PreviewProvider {
    static var previews: some View {
        BookCoverView(book: DBBook())
    }
}

