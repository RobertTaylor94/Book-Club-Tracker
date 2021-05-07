//
//  ContentView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    //    @AppStorage("onBoardingShowing") var isOnboardingShowing = true
    @State private var books: Results<DBBook>?
    let realm = try! Realm()
    
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                
                if books != nil {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(books!.reversed()) { i in
                                ZStack {
                                    BookCoverView(progressValue: i.progressValue, bookID: i.id, bookTitle: i.title, bookAuthor: i.authors, bookDescription: i.desc, bookImgUrl: i.imgurl, book: i)
                                    VStack(alignment: .trailing, spacing: 20) {
                                        HStack {
                                        
                                            Button(action: {
                                            deleteBook(filter: i.title)
                                            updateBooks()
                                        }, label: {
                                            Text("Delete")
                                                .font(.caption).foregroundColor(.white).padding().background(Color.red).cornerRadius(20).shadow(color: .black, radius: 7, x: 0.0, y: 0.0)
                                    })
                                        }.padding()
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    .onAppear(){
                        updateBooks()
                    }
                    .padding()
                } else {
                    Text("Add Your First Book!")
                        .padding()
                        .onAppear(){
                            updateBooks()
                        }
                }
                Spacer()
                    
                    .navigationTitle("Book Club")
            }
            
        }
    }
    
    func updateBooks() {
        books = realm.objects(DBBook.self)
    }
    func deleteBook(filter: String) {
        let book = books?.filter("title CONTAINS %@", filter)
        
        do {
            try realm.write {
                realm.delete(book!)
            }
        } catch {
            print("Error deleting from context, \(error)")
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
