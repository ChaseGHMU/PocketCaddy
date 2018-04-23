//
//  PracticeTest.swift
//  PocketCaddyUITests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest

class PracticeTest: XCTestCase {
        
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
        
        let app = XCUIApplication()
        app.tabBars.buttons["Practice"].tap()
        
        let addButton = app.navigationBars["Practice"].buttons["Add"]
        addButton.tap()
        
        let driverPickerWheel = app/*@START_MENU_TOKEN@*/.pickerWheels["Driver"]/*[[".pickers.pickerWheels[\"Driver\"]",".pickerWheels[\"Driver\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        driverPickerWheel.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        addButton.tap()
        textField.tap()
        driverPickerWheel.tap()
        submitButton.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
