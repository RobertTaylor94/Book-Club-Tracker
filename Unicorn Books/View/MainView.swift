//
//  TabView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 06/05/2021.
//

import SwiftUI

enum SelectedTab: Hashable {
    case home
    case addbook
}

struct MainView: View {
    
    @State var selectedTab: SelectedTab = .home
    
    var body: some View {
        
        TabView(selection: self.$selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }.tag(SelectedTab.home)
            AddBookView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Add Book")
                }.tag(SelectedTab.addbook)
        }.onOpenURL(perform: { url in
            if url.absoluteString == "widget-deeplink://addbook" {
                self.selectedTab = .addbook
            }
        })
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
