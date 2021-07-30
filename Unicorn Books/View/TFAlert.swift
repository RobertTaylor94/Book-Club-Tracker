//
//  TFAlert.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/07/2021.
//

import SwiftUI
import Foundation

struct TFAlert: View {
    
    let screenSize = UIScreen.main.bounds
    
    @Binding var isShown: Bool
    @Binding var text: String
    @Binding var totalPages: Int
    @Binding var currentPage: Int
    @Binding var progressValue: Float
    var title: String = "Update Page Number"
    
    var body: some View {
        
        VStack(spacing: 30){
            Text(title)
                .font(.title2)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack(spacing: 30) {
                
                Button("Done") {
                    print(text)
                    progressValue = updateProgress(text: Int(text)!)
                    isShown = false
                }
                .padding()
                .background(Color("BookTileColorOne"))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .foregroundColor(.white)
                .font(.title3)
                .disabled(self.text.isEmpty)
                
                Button("Cancel") {
                    isShown = false
                }
                .padding()
                .background(Color("BookTileColorOne"))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .foregroundColor(.white)
                .font(.title3)
            }
            
        }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
        .background(Color(#colorLiteral(red: 0.8973950744, green: 0.8920606971, blue: 0.9014957547, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
//        .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 6, x: -9, y: -9)
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
    }
    
    
    func updateProgress(text: Int) -> Float {
        let currentPage = text
        let tpage: Float = Float(totalPages)
        let cpage: Float = Float(currentPage)
        let newProgress = Float(cpage/tpage)
        let roundedProgress = round(Double(newProgress * 100)) / 100.0
        print(newProgress)
        return Float(roundedProgress)
    }
}

struct TFAlert_Previews: PreviewProvider {
    static var previews: some View {
        TFAlert(isShown: .constant(true), text: .constant(""), totalPages: .constant(400), currentPage: .constant(287), progressValue: .constant(0.71))
    }
}
