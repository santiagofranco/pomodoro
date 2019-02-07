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
    
    private class MockStateManager: StateManager {
        
        var currentState: State = .initial
        var loadCurrentStateCalled = false
        var startTimerCalled = false
        var runningInformation = RunningInformation(hoursLeft: "123", minutesLeft: "23", secondsLeft: "23", breakText: "2", alertText: "1", notificationText: "popover")
        var observer: StateManagerTimeObserver? = nil
        var pauseTimerCalled = false
        var configuration: InitialConfiguration?
        
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
        
    }

    private class MockView: MainPomodoroView {
        var showInitialViewCalled = false
        var showRunningViewCalled = false
        var runningInformation: RunningInformation? = nil
        var showPauseViewCalled = false
        
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
    }
}
