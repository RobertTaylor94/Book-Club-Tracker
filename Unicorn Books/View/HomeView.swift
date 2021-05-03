//
//  ContentView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
//    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack {
            
//            Text("Unicorn Book Club")
//                .font(.largeTitle)
//                .foregroundColor(Color("mainTextColor"))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    //Call book objects from Realm database to populate covers
                    
                    BookCoverView()
                    BookCoverView()
                    BookCoverView()
                }
            }
            .padding()
            NavigationLink("Add Book", destination: AddBookView())
                .foregroundColor(.white)
                .font(.body)
                .padding()
                .background(Color("mainTextColor"))
                .cornerRadius(20)
        }
        .navigationTitle("Unicorn Book Club")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
