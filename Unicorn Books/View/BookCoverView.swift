//
//  BookCover.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/04/2021.
//

import SwiftUI

struct BookCoverView: View {
    
//    @State var progressValue: Float = 0.0
    @State var bookID: String = ""
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookDescription: String = ""
    @State var bookImgUrl: String = ""
    
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            VStack(alignment: .leading, spacing: 16.0) {
                Text("\(bookTitle)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(bookAuthor)")
                    .font(.caption)
    //            Image()
                Text("\(bookDescription)")
                    .fontWeight(.light)
            }
            .frame(width: 200, height: 300)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            
//            ProgressBar(progress: self.$progressValue)
//                .frame(width: 100, height: 100)
//                .padding()
//
//            Stepper("", value: $progressValue, in: 0...1, step: 0.1)

            
        }
    }
}


struct BookCover_Previews: PreviewProvider {
    static var previews: some View {
        BookCoverView()
    }
}
