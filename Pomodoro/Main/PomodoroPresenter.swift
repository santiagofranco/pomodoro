//
//  PomodoroPresenter.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class PomodoroPresenter {
    
    var stateManager: StateManager
    let view: MainPomodoroView
    
    init(stateManager: StateManager, view: MainPomodoroView) {
        self.stateManager = stateManager
        self.view = view
    }
}


extension PomodoroPresenter: MainPomodoroViewDelegate {
    func viewDidAppear() {
        stateManager.unsubscribe()
        let currentState = stateManager.loadCurrentState()
        switch currentState {
        case .initial:
            view.showInitialView()
            return
            
        case .running:
            stateManager.subscribe(observer: self)
            view.showRunningView(with: stateManager.loadRunningInformation())
            return
        
        case .paused:
            view.showPauseView(with: stateManager.loadRunningInformation())
            return
        }
        
    }
    
    func didTapStart(with configuration: InitialConfiguration) {
        stateManager.configuration = configuration
        stateManager.startTimer()
    }
    
    func didTapPause() {
        stateManager.pauseTimer()
    }
    
    func didTapResume() {
        stateManager.resumeTimer()
    }
}

extension PomodoroPresenter: StateManagerTimeObserver {
    func didUpdateTime() {
        view.showRunningView(with: stateManager.loadRunningInformation())
    }
}
