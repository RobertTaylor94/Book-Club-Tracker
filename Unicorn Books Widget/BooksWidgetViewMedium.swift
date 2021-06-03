//
//  BooksWidgetViewMedium.swift
//  Unicorn Books WidgetExtension
//
//  Created by Robert Taylor on 02/06/2021.
//

import Foundation
import SwiftUI


struct BooksWidgetViewMedium: View {
    
    let title: String
    let progress: Float
    let bookImgUrl: String
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            HStack {
                VStack {
                    Spacer()
                    Text(title)
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("\(String(format: "%.0f", progress*100))%")
                        .foregroundColor(.white)
                    Spacer()
                }.padding()
                
                Link(destination: URL(string: "widget-deeplink://addbook")!, label: {
                    Text("Add Book")
                        .frame(width: 100, height: 70)
                        .background(Color("DetailViewColorTwo"))
                        .cornerRadius(20)
                })
                
            }
            
        }
    }
}
