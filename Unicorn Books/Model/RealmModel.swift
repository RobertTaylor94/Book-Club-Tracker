//
//  RealmModel.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 04/05/2021.
//

import Foundation
import RealmSwift

class DBBook: Object, Identifiable {
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var authors : String = ""
    @objc dynamic var desc : String = ""
    @objc dynamic var imgurl : String = ""
    @objc dynamic var progressValue: Float = 0.0
    @objc dynamic var pageCount: Int = 0
    @objc dynamic var currentPage: Int = 0
}
