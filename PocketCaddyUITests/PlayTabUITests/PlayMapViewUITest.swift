//
//  PlayResultTest.swift
//  PocketCaddyUITests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest

class PlayResultTest: XCTestCase {
        
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
       
        //Start at hole1
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.pickerWheels["One (1)"]/*[[".pickers.pickerWheels[\"One (1)\"]",".pickerWheels[\"One (1)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let element3 = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let element = element3.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Two (2)"]/*[[".pickers.pickerWheels[\"Two (2)\"]",".pickerWheels[\"Two (2)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.tap()
        element3.buttons["Play"].tap()
        app.buttons["Next Arrow"].tap()
        element2.children(matching: .picker).element(boundBy: 0).pickerWheels["1"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["1"]/*[[".pickers.pickerWheels[\"1\"]",".pickerWheels[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Continue"].tap()
        
        let app = XCUIApplication()
        app.buttons["Next Arrow"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .picker).element(boundBy: 0).pickerWheels["1"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["1"]/*[[".pickers.pickerWheels[\"1\"]",".pickerWheels[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Continue"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
