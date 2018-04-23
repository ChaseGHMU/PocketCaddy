//
//  StartToPlayUITest.swift
//  PocketCaddyUITests
//
//  Created by Baoxin on 4/23/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest

class StartToPlayUITest: XCTestCase {
        
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
        //Start to paly the golf course, save the shots and putts, check the scorecard
        
        let app = XCUIApplication()
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let element = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Two (2)"]/*[[".pickers.pickerWheels[\"Two (2)\"]",".pickerWheels[\"Two (2)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.buttons["Play"].tap()
        
        let nextArrowButton = app.buttons["Next Arrow"]
        nextArrowButton.tap()
        
        let pickerWheel = element2.children(matching: .picker).element(boundBy: 0).pickerWheels["1"]
        pickerWheel.tap()
        
        let pickerWheel2 = app/*@START_MENU_TOKEN@*/.pickerWheels["1"]/*[[".pickers.pickerWheels[\"1\"]",".pickerWheels[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pickerWheel2.tap()
        
        let continueButton = app.buttons["Continue"]
        continueButton.tap()
        nextArrowButton.tap()
        pickerWheel.tap()
        pickerWheel2.tap()
        continueButton.tap()
        nextArrowButton.tap()
        pickerWheel.tap()
        pickerWheel2.tap()
        continueButton.tap()
        app.navigationBars["Hole 6"].buttons["Scorecard"].tap()
        app.navigationBars["PocketCaddy.PlayScorecardTableView"].buttons["Hole 6"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
