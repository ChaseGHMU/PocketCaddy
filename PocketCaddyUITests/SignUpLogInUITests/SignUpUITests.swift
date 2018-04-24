//
//  SignUpUITests.swift
//  SignUpUITests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest

class SignUpUITests: XCTestCase {
        
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
        //Create an account with valid and invalid account info.
        
        let app = XCUIApplication()
        app.buttons["Sign Up"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.tap()
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.tap()
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.tap()
        
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        app.alerts["Invalid Email & Password"].buttons["Ok"].tap()
        textField.tap()
        textField.swipeLeft()
        textField.tap()
        textField.swipeLeft()
        textField3.tap()
        submitButton.tap()
        app.alerts["Account Succesfully Created"].buttons["Ok"].tap()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
