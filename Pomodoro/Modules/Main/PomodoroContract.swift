//
//  PomodoroContract.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

protocol MainPomodoroView {
    
    var delegate: MainPomodoroViewDelegate? { get set }
    
    func showInitialView()
    func showRunningView(with info: RunningInformation)
    func showPauseView(with info: RunningInformation)
    func showPopoverNotificationView()
    func showFullScreenNotificationView()
}

protocol MainPomodoroViewDelegate {
    func viewDidAppear()
    func didTapStart(with configuration: InitialConfiguration)
    func didTapPause()
    func didTapResume()
    func didTapStop()
}
