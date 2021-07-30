//
//  TimerView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/07/2021.
//

import SwiftUI

struct TimerView: View {
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("DetailViewColorOne"), Color("DetailViewColorTwo")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            Text("Timer View")
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
