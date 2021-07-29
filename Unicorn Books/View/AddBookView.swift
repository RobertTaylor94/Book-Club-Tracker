//
//  AddBookView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import AlertToast
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import RealmSwift


struct AddBookView: View {
    
    @State public var searchText: String = ""
    @ObservedObject var fetcher = BookFetcher(search: "")
    @State private var showCancelButton: Bool = false
    @State private var showAlert = false
    let realm = try! Realm()
    
    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("search", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: {
                        self.fetcher.getJsonData(string: searchText)
                    }).foregroundColor(.primary).keyboardType(.webSearch)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                List(fetcher.books) { i in
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
                                    newBook.pageCount = i.pageCount
                                    self.saveBook(book: newBook)
                                showAlert.toggle()
                                    
                                }, label: {
                                    Text("Add Book")
                                        .padding().background(Color("Button")).cornerRadius(20).foregroundColor(.white)
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
                .resignKeyboardOnDragGesture()
                .padding()
                .toast(isPresenting: $showAlert) {
                    AlertToast(type: .complete(Color.green), title: "Added to Library")
                }
            }
            .padding()
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



//MARK: Preview

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

//MARK: Resign Keyboard

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
