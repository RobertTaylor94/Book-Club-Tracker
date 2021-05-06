//
//  DetailView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct DetailView: View {
    
    @State var progressValue: Float = 0.4
    @State var bookID: String = ""
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookDescription: String = ""
    @State var bookImgUrl: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var books: Results<DBBook>?
    let realm = try! Realm()
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(bookTitle).font(.title2)
            Text(bookAuthor).font(.caption)
            WebImage(url: URL(string: bookImgUrl)).resizable().frame(width: 200, height: 300).cornerRadius(10)
            ScrollView {
                Text(bookDescription).font(.caption)
            }.padding()
            ProgressBar(progress: $progressValue)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("DetailViewColorOne"), Color("DetailViewColorTwo")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
        
        
        
        
    }
    
    func removeBook() {
        
        books = realm.objects(DBBook.self)
        books = books?.filter("title CONTAINS %@", bookTitle)
        
        do {
            try realm.write {
                realm.delete(books!)
            }
        } catch {
            print("Error deleting from context, \(error)")
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
