//
//  PomodoroPresenterTest.swift
//  PomodoroTests
//
//  Created by Santi on 07/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
@testable import Pomodoro

class PomodoroPresenterTest: XCTestCase {

    //SUT
    var presenter: PomodoroPresenter!
    
    //Mocks
    private var stateManager: MockStateManager!
    private var view: MockView!
    
    override func setUp() {
        
        stateManager = MockStateManager()
        view = MockView()
        
        presenter = PomodoroPresenter(
            stateManager: stateManager,
            view: view)
    }

    override func tearDown() {
        view = nil
        stateManager = nil
        presenter = nil
    }
    
    func test_load_current_state_when_view_appear() {
        
        presenter.viewDidAppear()
        
        XCTAssertTrue(stateManager.loadCurrentStateCalled)
        
    }
    
    func test_unsusbcribe_from_state_manager_when_view_appear() {
        
        stateManager.observer = presenter
        
        presenter.viewDidAppear()
        
        XCTAssertNil(stateManager.observer)
        
    }
    
    func test_show_initial_view_when_view_appear_and_current_state_is_initial() {
        
        let givenState: State = .initial
        stateManager.currentState = givenState
        
        presenter.viewDidAppear()
        
        XCTAssertTrue(view.showInitialViewCalled)
        
    }
    
    func test_start_runnning_when_user_taps_start_button_with_given_configuration() {
        
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .fullScreen)
        
        presenter.didTapStart(with: givenConfiguration)
    
        XCTAssertNotNil(stateManager.configuration)
        XCTAssertTrue(stateManager.startTimerCalled)
        
    }
    
    func test_set_configuration_to_state_manager_when_user_taps_start_button_with_given_configuration() {
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .fullScreen)
        
        presenter.didTapStart(with: givenConfiguration)
        
        XCTAssertEqual(stateManager.configuration!, givenConfiguration)
    }
    
    func test_subscribe_timer_when_view_user_taps_start_button() {
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .fullScreen)
        
        presenter.didTapStart(with: givenConfiguration)
        
        XCTAssertNotNil(stateManager.observer)
    }
    
    func test_show_running_view_when_view_appear_and_current_state_is_running() {
        
        let givenState: State = .running
        stateManager.currentState = givenState
        let givenRunningInformation = RunningInformation(hoursLeft: "123", minutesLeft: "23", secondsLeft: "23", breakText: "2", alertText: "1", notificationText: "full")
        stateManager.runningInformation = givenRunningInformation
        
        presenter.viewDidAppear()
        
        XCTAssertTrue(view.showRunningViewCalled)
        XCTAssertFalse(view.showInitialViewCalled)
        XCTAssertNotNil(view.runningInformation)
        XCTAssertEqual(view.runningInformation!, givenRunningInformation)
    }
    
    func test_subscribe_timer_when_view_appear_and_current_state_is_running() {
        let givenState: State = .running
        stateManager.currentState = givenState
        
        presenter.viewDidAppear()
        
        XCTAssertNotNil(stateManager.observer)
    }
    
    func test_show_given_information_when_timer_update() {
        
        let givenRunningInformation = RunningInformation(hoursLeft: "123", minutesLeft: "23", secondsLeft: "23", breakText: "2", alertText: "1", notificationText: "full")
        stateManager.runningInformation = givenRunningInformation
        
        presenter.didUpdateTime()
        
        XCTAssertTrue(view.showRunningViewCalled)
        XCTAssertNotNil(view.runningInformation)
        XCTAssertEqual(view.runningInformation!, givenRunningInformation)
    }
    
    func test_pause_timer_when_user_taps_on_pause_button() {
        
        presenter.didTapPause()
        
        XCTAssertTrue(stateManager.pauseTimerCalled)
        
    }
    
    func test_show_pause_view_when_view_did_appear_and_current_state_is_paused() {
        
        let givenCurrentState: State = .paused
        stateManager.currentState = givenCurrentState
        let givenRunningInformation = RunningInformation(hoursLeft: "123", minutesLeft: "23", secondsLeft: "23", breakText: "2", alertText: "1", notificationText: "full")
        stateManager.runningInformation = givenRunningInformation
        
        presenter.viewDidAppear()
        
        XCTAssertTrue(view.showPauseViewCalled)
        XCTAssertFalse(view.showRunningViewCalled)
        XCTAssertNotNil(view.runningInformation)
        XCTAssertEqual(view.runningInformation!, givenRunningInformation)
        
    }
    
    func test_resume_timer_when_user_taps_on_resume_button() {
        
        presenter.didTapResume()
        
        XCTAssertTrue(stateManager.resumeTimerCalled)
        
    }
    
    func test_stop_timer_when_user_taps_on_stop_buttom() {
        
        presenter.didTapStop()
        
        XCTAssertTrue(stateManager.stopTimerCalled)
        
    }
    
    func test_show_popover_notification_view_when_running_timer_finish_and_configured_notification_is_popover() {
        
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .popover)
        stateManager.configuration = givenConfiguration
        
        presenter.didFinishRunningTimer()
        
        XCTAssertTrue(view.showPopoverNotificationViewCalled)
        XCTAssertFalse(view.showFullScreenNotificationViewCalled)
    }
    
    func test_show_full_screen_notification_view_when_running_timer_finish_and_configured_notification_is_full_screen() {
        
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .fullScreen)
        stateManager.configuration = givenConfiguration
        
        presenter.didFinishRunningTimer()
        
        XCTAssertTrue(view.showFullScreenNotificationViewCalled)
        XCTAssertFalse(view.showPopoverNotificationViewCalled)
    }
    
    func test_show_popover_notification_view_when_view_appear_and_configured_notification_is_popover() {
        
        let givenState: State = .notifying
        stateManager.currentState = givenState
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .popover)
        stateManager.configuration = givenConfiguration
        
        presenter.viewDidAppear()
        
        XCTAssertTrue(view.showPopoverNotificationViewCalled)
        XCTAssertFalse(view.showFullScreenNotificationViewCalled)
    }
    
    func test_show_full_screen_notification_view_when_view_appear_and_configured_notification_is_full_screen() {
        
        let givenState: State = .notifying
        stateManager.currentState = givenState
        let givenConfiguration = InitialConfiguration(time: .two, break: .ten, alert: .one, notificationType: .fullScreen)
        stateManager.configuration = givenConfiguration
        
        presenter.viewDidAppear()
        
        XCTAssertTrue(view.showFullScreenNotificationViewCalled)
        XCTAssertFalse(view.showPopoverNotificationViewCalled)
    }
    
    
    private class MockStateManager: StateManager {
        
        var currentState: State = .initial
        var loadCurrentStateCalled = false
        var startTimerCalled = false
        var runningInformation = RunningInformation(hoursLeft: "123", minutesLeft: "23", secondsLeft: "23", breakText: "2", alertText: "1", notificationText: "popover")
        var observer: StateManagerTimeObserver? = nil
        var pauseTimerCalled = false
        var configuration: InitialConfiguration?
        var resumeTimerCalled = false
        var stopTimerCalled = false
        
        func loadCurrentState() -> State {
            loadCurrentStateCalled = true
            return currentState
        }
        
        func startTimer() {
            startTimerCalled = true
        }
        
        func loadRunningInformation() -> RunningInformation {
            return runningInformation
        }
        
        func unsubscribe() {
            observer = nil
        }
        
        func subscribe(observer: StateManagerTimeObserver) {
            self.observer = observer
        }
        
        func pauseTimer() {
            pauseTimerCalled = true
        }
        
        func resumeTimer() {
            resumeTimerCalled = true
        }
        
        func stopTimer() {
            stopTimerCalled = true
        }
        
    }

    private class MockView: MainPomodoroView {
        var delegate: MainPomodoroViewDelegate?
        
        var showInitialViewCalled = false
        var showRunningViewCalled = false
        var runningInformation: RunningInformation? = nil
        var showPauseViewCalled = false
        var showPopoverNotificationViewCalled = false
        var showFullScreenNotificationViewCalled = false
        
        func showInitialView() {
            showInitialViewCalled = true
        }
        
        func showRunningView(with info: RunningInformation) {
            showRunningViewCalled = true
            self.runningInformation = info
        }
        
        func showPauseView(with info: RunningInformation) {
            showPauseViewCalled = true
            self.runningInformation = info
        }
        
        func showPopoverNotificationView() {
            showPopoverNotificationViewCalled = true
        }
        
        func showFullScreenNotificationView() {
            showFullScreenNotificationViewCalled = true
        }
    }
}
