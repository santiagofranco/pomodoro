//
//  RunningInformation.swift
//  Pomodoro
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

struct RunningInformation {
    let hoursLeft: String
    let minutesLeft: String
    let secondsLeft: String
    let breakText: String
    let alertText: String
    let notificationText: String
}

extension RunningInformation: Equatable {
    
}
