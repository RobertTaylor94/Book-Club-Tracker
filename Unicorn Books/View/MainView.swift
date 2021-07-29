//
//  TabView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 06/05/2021.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 4 {
                    migration.enumerateObjects(ofType: DBBook.className()) { (_, newDBBook) in
                        newDBBook!["pageCount"] = 0
                        newDBBook!["currentPage"] = 0
                    }
                }
            }
            )
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        }
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
            AddBookView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Add Book")
                }
            
            
        }
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
