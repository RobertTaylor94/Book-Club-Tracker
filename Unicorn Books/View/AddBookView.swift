//
//  AddBookView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct AddBookView: View {
    
    @State public var searchText: String = ""
    @ObservedObject var fetcher = BookFetcher(search: "")
    
    var body: some View {
        NavigationView {
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
                List(fetcher.books) { i in
                    
                    HStack {
                        if i.imgurl != "" {
                            WebImage(url: URL(string: i.imgurl)).resizable().frame(width: 120, height: 170)
                        } else {
                            Image(systemName: "books.vertical").resizable().frame(width: 120, height: 170)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(i.title).fontWeight(.bold)
                            Text(i.authors)
                            Text(i.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
                        }
                    }
                    
                    
                    
                }
            }



        }
        
        }.navigationTitle("Add New Book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

//struct BookItemView(title: String) {
//    var body: some View {
//        HStack {
//            Image("book")
//        }
//    }
//}
