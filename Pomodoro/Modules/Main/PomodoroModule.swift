//
//  PomodoroModule.swift
//  Pomodoro
//
//  Created by Santi on 11/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import Cocoa

class PomodoroModule {
    
    static func viewController() -> MainPomodoroViewController {
        
        guard let storyboard = NSStoryboard.main else {
            fatalError("Cant find main story board")
        }
        
        let identifier = NSStoryboard.SceneIdentifier("MainPomodoroViewController")
        
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainPomodoroViewController else {
            fatalError("Why cant i find MainPomodoroViewController? - Check Main.storyboard")
        }
        
        let presenter = PomodoroPresenter(stateManager: PomodoroStateManager(), view: viewcontroller)
        viewcontroller.delegate = presenter
        return viewcontroller
    }
}
