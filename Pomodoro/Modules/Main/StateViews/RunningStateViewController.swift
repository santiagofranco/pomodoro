//
//  RunningStateViewController.swift
//  Pomodoro
//
//  Created by Santi on 17/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Cocoa


protocol RunningStateViewControllerDelegate {
    
}

class RunningStateViewController: NSViewController {

    @IBOutlet weak var hoursLabel: NSTextField!
    @IBOutlet weak var minutesLabel: NSTextField!
    @IBOutlet weak var secondsLabel: NSTextField!
    
    let delegate: RunningStateViewControllerDelegate
    
    init(delegate: RunningStateViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(info: RunningInformation) {
        hoursLabel.stringValue = info.hoursLeft + "h"
        minutesLabel.stringValue = info.minutesLeft + "m"
        secondsLabel.stringValue = info.secondsLeft + "s"
    }
    
}
