//
//  AddBookView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import RealmSwift

struct AddBookView: View {
    
    @State public var searchText: String = ""
    @ObservedObject var fetcher = BookFetcher(search: "")
    let realm = try! Realm()
    
    var body: some View {
//        NavigationView {
        Form {
            Section(header: Text("")) {
                HStack{
                TextField("Search", text: $searchText)
                Button(action: {
                        self.fetcher.getJsonData(string: self.searchText)
                }, label: {
                    Image(systemName: "magnifyingglass.circle").resizable().frame(width: 30, height: 30)
                })
                }
            }

            Section(header: Text("")) {
                
//                ScrollView {
                    ForEach(fetcher.books) { i in
                        HStack {
                            
                            VStack {
                                if i.imgurl != "" {
                                    WebImage(url: URL(string: i.imgurl)).resizable().frame(width: 120, height: 170).aspectRatio(contentMode: .fit)
                                } else {
                                    Image(systemName: "books.vertical").resizable().frame(width: 120, height: 170).aspectRatio(contentMode: .fit)
                                }
                                
                                Button(action: {
                                    
                                    let newBook = DBBook()
                                    newBook.title = i.title
                                    newBook.id = i.id
                                    newBook.authors = i.authors
                                    newBook.desc = i.desc
                                    newBook.imgurl = i.imgurl
                                    
                                    self.saveBook(book: newBook)
                                    
                                }, label: {
                                    Text("Add Book")
                                        .padding().background(Color("mainTextColor")).cornerRadius(20).foregroundColor(.white)
                                })
                                
                            }
                            VStack {
                                Text(i.title).fontWeight(.bold)
                                Text(i.authors)
                                Text(i.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
                            }
                        
                        }
                        Spacer()
                    }
//                }
            }



        }
        .navigationTitle("Add New Book")

    }
    
    func saveBook(book: DBBook) {
        do {
            try realm.write {
                realm.add(book)
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
