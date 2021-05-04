//
//  BookManager.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 03/05/2021.
//

import Foundation
import SwiftUI
import SwiftyJSON

public class BookFetcher: ObservableObject {
    
    @Published var books = [Book]()
    
    init(search: String) {
        getJsonData(string: search)
    }
    
    func getJsonData(string: String) {
        
        books.removeAll(keepingCapacity: false)
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(string.replacingOccurrences(of: " ", with: "+"))&maxResults=5"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            if let items = json["items"].array {
            
            for i in items {
                let id = i["id"].stringValue
                let title = i["volumeInfo"]["title"].stringValue
                let authors = i["volumeInfo"]["authors"].array!
                var author = ""
                for j in authors {
                    author += "\(j.stringValue)"
                }
                let description = i["volumeInfo"]["description"].stringValue
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                
                DispatchQueue.main.async {
                    self.books.append(Book(id: id, title: title, authors: author, desc: description, imgurl: imurl))
                }
            
            }
            
            } else {
                print("No data to decode.")
            }
        }.resume()
        
     
//
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil {
//                print(error!)
//            } else {
//                if let urlContent = data {
//                    do {
//                        let jsonResult = try JSONDecoder().decode(Book.self, from: urlContent)
//
//                        DispatchQueue.main.async {
//                            self.books.append(jsonResult)
//                        }
//
//                    } catch {
//                        print("failed\(error)")
//                    }
//                }
//            }
//        }
//        task.resume()
        
        
    }
   
}

struct Book: Identifiable {
    var id: String
    var title: String
    var authors: String
    var desc: String
    var imgurl: String
}



//struct Book: Codable, Identifiable {
//    let id = UUID()
//    let items: [Items]
//}
//
//struct Items: Codable, Identifiable {
//    let id = UUID()
//    let volumeInfo: VolumeInfo
//}
//
//struct VolumeInfo: Codable, Identifiable {
//    let id = UUID()
//    let title: String
//    let authors: [String]
//    let description: String?
//    let imageLinks: ImageLinks
//}
//
//struct Authors: Codable, Identifiable {
//    let id = UUID()
//    let author: String
//}
//
//struct ImageLinks: Codable, Identifiable {
//    let id = UUID()
//    let smallThumbnail: String?
//}
