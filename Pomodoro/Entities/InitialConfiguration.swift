//
//  InitialConfiguration.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

struct InitialConfiguration {
    
    let time: TimeHours
    let `break`: BreakTimeMinutes
    let alert: AlertTimeMinutes
    let notificationType: NotificationType
    
    enum TimeHours {
        case two
        case oneAndHalf
    }
    
    enum BreakTimeMinutes {
        case five
        case ten
        case fifteen
    }
    
    enum AlertTimeMinutes {
        case none
        case one
        case two
        case five
    }
    
    enum NotificationType {
        case popover
        case fullScreen
    }
}

extension InitialConfiguration: Equatable {
    
}
