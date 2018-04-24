//
//  SignUpTest.swift
//  PocketCaddyTests
//
//  Created by Baoxin on 4/22/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//
import UIKit
import Alamofire
import XCTest
@testable import PocketCaddy

class SignUpTest: XCTestCase {

    func testInvalidateEmail(){
        let signUpViewController = SignUpViewController()
        XCTAssertFalse(signUpViewController.validateEmail(enteredEmail:"!!!"))
    }
   
    func testInvalidatePassword(){
        let signUpViewController = SignUpViewController()
        XCTAssertFalse(signUpViewController.validatePassword(enteredPass:"!!!"))
    }

}
