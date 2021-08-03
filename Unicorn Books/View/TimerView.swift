//
//  TimerView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/07/2021.
//

import SwiftUI
import RealmSwift

struct TimerView: View {
    
    var hours = Array(0...23)
    var minutes = Array(0...120)
    @State private var selectedHours = 0
    
    @ObservedObject var viewModel = TimerViewModel()
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("DetailViewColorOne"), Color("DetailViewColorTwo")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack {
                Spacer()
                TimerBarView(progress: $viewModel.progress)
                    .frame(width: 200, height: 200, alignment: .center)
                Spacer()
                HStack{
                    
                    Text("\(viewModel.calculate()/3600,specifier: "%02d") :")
                        .font(.largeTitle)
                    
                    Text("\((viewModel.calculate() / 60) % 60,specifier: "%02d") :")
                        .font(.largeTitle)
                    
                    Text("\(viewModel.calculate() % 60,specifier: "%02d")")
                        .font(.largeTitle)
                }

                Spacer()
                HStack(spacing: 75) {
                    
                    //Start Button
                    Button(action: {
                        viewModel.startButtonPressed()
                    }, label: {
                        Text("Start")
                            .padding()
                            .font(.title2)
                            .background(Color("BookTileColorOne"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    })
                    
                    //Reset Button
                    Button(action: {
                        viewModel.resetButtonPressed()
                    }, label: {
                        Text("Reset")
                            .padding()
                            .font(.title2)
                            .background(Color("BookTileColorTwo"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    })
                }
                
                Picker("", selection: $viewModel.selectedMinutes) {
                    ForEach(0..<self.minutes.count) {
                        Text("\(self.minutes[$0]) minutes")
                    }
                }
                .opacity(viewModel.showButton ? 1 : 0)
            }
        }
    }
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
