//
//  StatsViewModel.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 04/08/2021.
//

import Foundation
import SwiftUI
import RealmSwift

class StatsViewModel: ObservableObject {
    
    @Published var books: Results<DBBook>?
    
    let realm = try! Realm()
    
    func updateBooks() {
        books = realm.objects(DBBook.self)
    }
    
}
