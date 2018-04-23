//
//  AddScoreViewControllerTest.swift
//  PocketCaddyTests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import XCTest
import UIKit
import Alamofire
@testable import PocketCaddy

class AddScoreViewControllerTest: XCTestCase {
    
    func testpickerView(){
        let addScoreViewController = UIPickerViewDataSource(),UIPickerViewDelegate()
        

        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            strokesTitle = strokes[row]
        }else{
            puttsTitle = putts[row]
        }
    }
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}
