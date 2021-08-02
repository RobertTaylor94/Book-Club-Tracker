//
//  TimerView.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 30/07/2021.
//

import SwiftUI
import RealmSwift

struct TimerView: View {
    
    @State var progress: Float = 0.0
    @State private var timer: Timer?
    var hours = Array(0...23)
    var minutes = Array(0...120)
    @State private var selectedMinutes = 0
    @State private var selectedHours = 0
    @State private var selectedSeconds = 0
    @State private var totalSeconds = 0
    @State private var showButton = true
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("DetailViewColorOne"), Color("DetailViewColorTwo")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack {
                Spacer()
                TimerBar(progress: $progress)
                    .frame(width: 200, height: 200, alignment: .center)
                Spacer()
                HStack{
                    
                    Text("\(calculate()/3600,specifier: "%02d") :")
                        .font(.largeTitle)
                    
                    Text("\((calculate() / 60) % 60,specifier: "%02d") :")
                        .font(.largeTitle)
                    
                    Text("\(calculate() % 60,specifier: "%02d")")
                        .font(.largeTitle)
                }

                Spacer()
                HStack(spacing: 75) {
                    Button(action: {
                        selectedSeconds = selectedMinutes*60
                        showButton.toggle()
                        totalSeconds = selectedSeconds
                        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            selectedSeconds -= 1
                            updateProgress()
                            if selectedSeconds <= 0 {
                                self.timer?.invalidate()
                                self.selectedMinutes = 0
                                self.selectedSeconds = 0
                                self.progress = 1.0
                                showButton.toggle()
                            }
                        }
                    }, label: {
                        Text("Start")
                            .padding()
                            .font(.title2)
                            .background(Color("BookTileColorOne"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    })
                    Button(action: {
                        self.timer?.invalidate()
                        selectedSeconds = 0
                        selectedMinutes = 0
                        progress = 0.0
                        showButton.toggle()
                    }, label: {
                        Text("Reset")
                            .padding()
                            .font(.title2)
                            .background(Color("BookTileColorTwo"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    })
                }
                
                Picker("", selection: $selectedMinutes) {
                    ForEach(0..<self.minutes.count) {
                        Text("\(self.minutes[$0]) minutes")
                    }
                }
                .opacity(showButton ? 1 : 0)
            }
        }
    }
    
    func calculate() -> Int {
        let totalSecs = selectedSeconds
        return totalSecs
    }
    
    func updateProgress() {
        let floatTotal = Float(totalSeconds)
        let floatSelected = Float(selectedSeconds)
        let currentProgress = floatSelected/floatTotal
        progress = Float(currentProgress)
    }
}

struct TimerBar: View {
    
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
