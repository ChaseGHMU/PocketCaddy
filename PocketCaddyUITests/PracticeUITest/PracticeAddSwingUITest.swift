//
//  PracticeViewTest.swift
//  PocketCaddyUITests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest

class PracticeViewTest: XCTestCase {
        
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
        
        //add swings to the club
        // Test adding the empty, large number and add the exist number
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["99 yards"]/*[[".cells.staticTexts[\"99 yards\"]",".staticTexts[\"99 yards\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let swingsNavigationBar = app.navigationBars["Swings"]
        let addButton = swingsNavigationBar.buttons["Add"]
        addButton.tap()
        
        let addNewSwingAlert = app.alerts["Add New Swing"]
        let addButton2 = addNewSwingAlert.buttons["Add"]
        addButton2.tap()
        
        let yesButton = app.alerts["Are you sure"].buttons["Yes"]
        yesButton.tap()
        addButton.tap()
        addButton2.tap()
        addButton.tap()
        addNewSwingAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.tap()
        addButton2.tap()
        yesButton.tap()
        swingsNavigationBar.buttons["Practice"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
