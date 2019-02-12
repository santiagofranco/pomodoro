//
//  ViewController.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Cocoa

class MainPomodoroViewController: NSViewController {

    var delegate: MainPomodoroViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW DID LOAD")
    }

    override var representedObject: Any? {
        didSet {
        
            print("RELOAD VIEW")
            
        }
    }
    
    override func viewDidAppear() {
        print("VIEW DID APPEAR")
        delegate?.viewDidAppear()
    }


}

extension MainPomodoroViewController: MainPomodoroView {
    
    func showInitialView() {
        
    }
    
    func showRunningView(with info: RunningInformation) {
        
    }
    
    func showPauseView(with info: RunningInformation) {
        
    }
    
    func showPopoverNotificationView() {
        
    }
    
    func showFullScreenNotificationView() {
        
    }
}
