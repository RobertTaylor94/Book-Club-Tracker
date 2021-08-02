//
//  BookStatsView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookStatsView: View {
    
    //Variable
    var bookImgUrl: String = ""
    var bookTitle: String = ""
    var bookAuthor: String = ""
    var totalPages: String = ""
    var timeToRead: String = "It took you __ to read this book"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            if bookImgUrl != "" {
                WebImage(url: URL(string: bookImgUrl)).resizable().frame(minWidth: 45, idealWidth: 60, maxWidth: .infinity, minHeight: 70, idealHeight: 85, maxHeight: 85).aspectRatio(contentMode: .fit).cornerRadius(10)
            } else {
                Image(systemName: "books.vertical").resizable().frame(minWidth: 90, idealWidth: 120, maxWidth: .infinity, minHeight: 140, idealHeight: 170, maxHeight: 170).cornerRadius(10)
            }
            Text("\(bookTitle)")
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
            Text("\(bookAuthor)")
                .font(.caption)
            Text("\(totalPages) pages")
            Text("\(timeToRead)")
                .minimumScaleFactor(0.7)
        }
        .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 138, idealHeight: 235, maxHeight: 235)
        .foregroundColor(.white)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("BookTileColorTwo"), Color("BookTileColorOne")]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
    }
}

struct BookStatsView_Previews: PreviewProvider {
    static var previews: some View {
        BookStatsView(bookImgUrl: "", bookTitle: "Harry Potter", bookAuthor: "J K Rowling", totalPages: "400", timeToRead: "3 hours")
    }
}
