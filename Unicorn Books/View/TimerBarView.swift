//
//  TimerBarView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 03/08/2021.
//

import SwiftUI

struct TimerBarView: View {
    
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 40.0)
                .opacity(0.3)
                .foregroundColor(Color.purple)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 40.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("DetailViewColorTwo"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
        
        
    }
}

struct TimerBarView_Previews: PreviewProvider {
    static var previews: some View {
        TimerBarView(progress: .constant(1.0))
    }
}
