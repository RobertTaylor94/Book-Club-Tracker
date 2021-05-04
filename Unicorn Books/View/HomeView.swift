//
//  ContentView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    @AppStorage("onBoardingShowing") var isOnboardingShowing = true
    @State private var books: Results<DBBook>?
    let realm = try! Realm()
    
    var body: some View {
        NavigationView {
            VStack {
//                Text("Unicorn Book Club")
                Spacer()
                
                if books != nil {
                
                ScrollView(.horizontal, showsIndicators: false) {
                   
                    ForEach(books!) { i in
                        HStack {
                        BookCoverView(bookID: i.id, bookTitle: i.title, bookAuthor: i.authors, bookDescription: i.desc, bookImgUrl: i.imgurl)
                        }
                    }
                    
                }.onAppear(){
                    updateBooks()
                }
                .padding()
                } else {
                    Text("Add Your First Book!")
                        .padding()
                        .background(Color("mainTextColor"))
                        .onAppear(){
                            updateBooks()
                        }
                }
                
                
                
                NavigationLink("Add Book", destination: AddBookView())
                    .foregroundColor(.white)
                    .font(.body)
                    .padding()
                    .background(Color("mainTextColor"))
                    .cornerRadius(20)
                Spacer()
            }
            .navigationTitle("Book Club")
//            .navigationBarHidden(true)
        }
        
        
    }
    
    func updateBooks() {
        books = realm.objects(DBBook.self)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


//List(books!) { i in
//    Text(i.title)
//}.onAppear(){
//    self.updateBooks()
//}
