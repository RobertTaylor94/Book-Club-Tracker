//
//  TimerViewModel.swift
//  Unicorn Books
//
//  Created by Robert Taylor on 03/08/2021.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    
    @Published var selectedSeconds = 0
    @Published var selectedMinutes = 0
    @Published var totalSeconds = 0
    @State var timer: Timer?
    @Published var progress: Float = 1.0
    @Published var showButton = true
    
    
    func startButtonPressed() {
        showButton.toggle()
        selectedSeconds = selectedMinutes*60
        totalSeconds = selectedSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.selectedSeconds -= 1
            print(self.selectedSeconds)
            self.updateProgress()
            if self.selectedSeconds <= 0 {
                timer.invalidate()
                self.selectedMinutes = 0
                self.selectedSeconds = 0
                self.progress = 1.0
                self.showButton.toggle()
            }
        }
    }
    
    
    func resetButtonPressed() {
        selectedSeconds = 0
        selectedMinutes = 0
    }
    
    func updateProgress() {
        let floatTotal = Float(totalSeconds)
        let floatSelected = Float(selectedSeconds)
        let currentProgress = floatSelected/floatTotal
        progress = Float(currentProgress)
    }
    
    func calculate() -> Int {
        let totalSecs = selectedSeconds
        return totalSecs
    }
    
    
}
