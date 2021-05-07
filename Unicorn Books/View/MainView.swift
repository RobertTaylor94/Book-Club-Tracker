//
//  TabView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 06/05/2021.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
            AddBookView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Add Book")
                }
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Groups")
                }
        }
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
