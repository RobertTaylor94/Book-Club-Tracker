//
//  BooksWidgetView.swift
//  Unicorn Books WidgetExtension
//
//  Created by Robert Taylor on 02/06/2021.
//

import Foundation
import SwiftUI

struct BooksWidgetView: View {
    
    var book = WidgetBook(title: "Scarecrow", progress: 0.1)
    
    var body: some View {
        ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [Color("BookTileColorOne"), Color("BookTileColorTwo")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    VStack {
                        Spacer()
                        Text("Current Book: ")
                            .font(.caption)
                        Spacer()
                        Text(book.title)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.8)
                        Spacer()
                        Text("Progress: 10%")
                        Spacer()
                    }.foregroundColor(.white)
                    
                }
    }
}
