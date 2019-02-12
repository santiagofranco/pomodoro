//
//  ViewController.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Cocoa

class MainPomodoroViewController: NSViewController {

    lazy var initialStateViewController: InitialStateViewController = {
       InitialStateViewController(delegate: self)
    }()
    
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
        self.view = initialStateViewController.view
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

extension MainPomodoroViewController: InitialStateViewControllerDelegate {
    func didTapStart(viewController: InitialStateViewController) {
        
        guard let time = viewController.time,
            let `break` = viewController.break,
            let alert = viewController.alert,
            let notification = viewController.notification else {
                fatalError("You need to configure all options")
        }
        
        let config = InitialConfiguration(
            time: time,
            break: `break`,
            alert: alert,
            notificationType: notification
        )
        
        delegate?.didTapStart(with: config)
    }
}

extension InitialStateViewController {
    
    var time: InitialConfiguration.TimeHours? {
        if time2h.state == .on {
            return .two
        }
        
        if time130h.state == .on {
            return .oneAndHalf
        }
        
        return nil
    }
    
    var `break`: InitialConfiguration.BreakTimeMinutes? {
        if self.break15.state == .on {
            return .fifteen
        }
        
        if self.break10.state == .on {
            return .ten
        }
        
        if break5.state == .on {
            return .five
        }
        
        return nil
    }
    
    var alert: InitialConfiguration.AlertTimeMinutes? {
        if alert5.state == .on {
            return .five
        }
        
        if alert2.state == .on {
            return .two
        }
        
        if alert1.state == .on {
            return .one
        }
        
        if alertNone.state == .on {
            return .none
        }
        
        return nil
    }
    
    var notification: InitialConfiguration.NotificationType? {
        
        if notificationPopover.state == .on {
            return .popover
        }
        
        if notificationFullScreen.state == .on {
            return .fullScreen
        }
        
        return nil
    }
    
}


