//
//  InitialStateViewController.swift
//  Pomodoro
//
//  Created by Santi on 12/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Cocoa

protocol InitialStateViewControllerDelegate {
    func didTapStart(viewController: InitialStateViewController)
}

class InitialStateViewController: NSViewController {

    @IBOutlet weak var time2h: NSButton!
    @IBOutlet weak var time130h: NSButton!
    @IBOutlet weak var break5: NSButton!
    @IBOutlet weak var break10: NSButton!
    @IBOutlet weak var break15: NSButton!
    @IBOutlet weak var alert5: NSButton!
    @IBOutlet weak var alert2: NSButton!
    @IBOutlet weak var alert1: NSButton!
    @IBOutlet weak var alertNone: NSButton!
    @IBOutlet weak var notificationPopover: NSButton!
    @IBOutlet weak var notificationFullScreen: NSButton!
    
    let delegate: InitialStateViewControllerDelegate
    
    init(delegate: InitialStateViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time2h.state = .on
        break10.state = .on
        alert2.state = .on
        notificationPopover.state = .on
    }
    
    @IBAction func timeRadioChanged(_ sender: Any) {
    }
    @IBAction func breakRadioChanged(_ sender: Any) {
    }
    @IBAction func alertRadioChanged(_ sender: Any) {
    }
    @IBAction func notificationRadioChanged(_ sender: Any) {
    }
    @IBAction func startButtonPushed(_ sender: Any) {
        delegate.didTapStart(viewController: self)
    }
}
