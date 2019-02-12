//
//  PomodoroStateManager.swift
//  Pomodoro
//
//  Created by Santi on 11/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class PomodoroStateManager: StateManager {
    
    private var currentState: State = .initial
    private var runningTimer: Timer? = nil
    private var currentSecondsLeft = 0
    
    var observer: StateManagerTimeObserver?
    var configuration: InitialConfiguration? {
        didSet {
            updateCurrentSecondsLeft()
        }
    }
    

    func loadCurrentState() -> State {
        return currentState
    }
    
    func startTimer() {
        initializeTimer()
    }
    
    func loadRunningInformation() -> RunningInformation {
        return RunningInformation(
            hoursLeft: "",
            minutesLeft: "",
            secondsLeft: "",
            breakText: "",
            alertText: "",
            notificationText: ""
        )
    }
    
    func unsubscribe() {
        observer = nil
    }
    
    func subscribe(observer: StateManagerTimeObserver) {
        self.observer = observer
    }
    
    func pauseTimer() {
        runningTimer?.invalidate()
        currentState = .paused
    }
    
    func resumeTimer() {
        self.startTimer()
    }
    
    func stopTimer() {
        runningTimer?.invalidate()
        currentState = .initial
    }
    
    
    fileprivate func initializeTimer() {
        currentState = .running
        runningTimer = Timer.init(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func updateTimer() {
        currentSecondsLeft = currentSecondsLeft - 1
        
        if isTimeFinished() {
            if currentState == .running {
                currentState = .notifying
                updateCurrentSecondsLeft()
                observer?.didFinishRunningTimer()
                return
            }
            
            if currentState == .notifying {
                currentState = .running
                updateCurrentSecondsLeft()
            }
            return
        }
        
        observer?.didUpdateTime()
    }
    
    fileprivate func isTimeFinished() -> Bool {
        return currentSecondsLeft <= 0
    }
    
    fileprivate func updateCurrentSecondsLeft() {
        guard let config = self.configuration else {
            return
        }
        
        if currentState == .notifying {
            currentSecondsLeft = config.break.seconds
            return
        }
        
        currentSecondsLeft = config.time.seconds
    }
    
}


fileprivate extension InitialConfiguration.TimeHours {
    
    var seconds: Int {
        switch self {
        case .two:
            return 7200
        case .oneAndHalf:
            return 5400
        }
    }
}

fileprivate extension InitialConfiguration.BreakTimeMinutes {
    
    var seconds: Int {
        switch self {
        case .fifteen:
            return 900
        case .ten:
            return 600
        case .five:
            return 300
        }
    }
}
