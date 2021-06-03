//
//  BooksWidgetView.swift
//  Unicorn Books WidgetExtension
//
//  Created by Robert Taylor on 02/06/2021.
//

import Foundation
import SwiftUI

struct BooksWidgetViewSmall: View {
    
    let title: String
    let progress: Float
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .minimumScaleFactor(0.6)
                Spacer()
                Text("\(String(format: "%.0f", progress*100))%")
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
        }
    }
}
