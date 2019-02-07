//
//  ViewController.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Cocoa

class MainPomodoroViewController: NSViewController {

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
    }


}

extension MainPomodoroViewController {
    static func refreshedController() -> MainPomodoroViewController {
        
        guard let storyboard = NSStoryboard.main else {
            fatalError("Cant find main story board")
        }
        
        let identifier = NSStoryboard.SceneIdentifier("MainPomodoroViewController")
        
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainPomodoroViewController else {
            fatalError("Why cant i find MainPomodoroViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
