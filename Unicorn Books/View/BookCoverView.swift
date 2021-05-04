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
    
    @State var progressValue: Float = 0.0
    @State var bookID: String = ""
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookDescription: String = ""
    @State var bookImgUrl: String = ""
    
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            VStack(alignment: .leading, spacing: 16.0) {
                if bookImgUrl != "" {
                    WebImage(url: URL(string: bookImgUrl)).resizable().frame(width: 120, height: 170)
                } else {
                    Image(systemName: "books.vertical").resizable().frame(width: 120, height: 170)
                }
                Text("\(bookTitle)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(bookAuthor)")
                    .font(.caption)
    //            Image()
                Text("\(bookDescription)")
                    .fontWeight(.light)
                    .lineLimit(4)
            }
            .frame(width: 200, height: 350)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            
            ProgressBar(progress: self.$progressValue)
                .frame(width: 100, height: 100)
                .padding()

            Stepper("", value: $progressValue, in: 0...1, step: 0.1)

            
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
        BookCoverView()
    }
}

