//
//  StatsView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 28/07/2021.
//

import SwiftUI
import RealmSwift

struct StatsView: View {
    
    //Variables
    @State private var isShowing: Bool = false
    @State private var books: Results<DBBook>?
    let realm = try! Realm()

    var body: some View {
        
        VStack(spacing: 30) {
            //Graph at top of weekly reading
            Spacer()
            //Timer to track current reading session
            Button(action: {
                isShowing.toggle()
            }, label: {
                Text("Read Now")
                    .padding()
                    .font(.title)
                    .background(Color("Button"))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }).sheet(isPresented: $isShowing, content: {
                TimerView()
            })
            
            //Previous book time length to read
            if books != nil {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(books!.reversed()) { i in
                            BookStatsView(
                                bookImgUrl: i.imgurl,
                                bookTitle: i.title,
                                bookAuthor: i.authors,
                                totalPages: "\(i.pageCount)",
                                timeToRead: i.timeToRead
                            )
                        }
                    }
                }
                .padding()
                .onAppear(){
                    updateBooks()
                }
            } else {
                Text("No stats available")
                    .onAppear(){
                        updateBooks()
                    }
            }
            
            
        }//VstackEnd
        
    }
    
    func updateBooks() {
        books = realm.objects(DBBook.self)
    }
    
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
