//
//  LogInUITests.swift
//  PocketCaddyUITests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest

class LogInUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        //Login with valid and invalid account info.
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let okButton = app.alerts["Unable to Login"].buttons["Ok"]
        okButton.tap()
        textField.tap()
        loginButton.tap()
        okButton.tap()
        textField.tap()
        secureTextField.tap()
        secureTextField.tap()
        loginButton.tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
