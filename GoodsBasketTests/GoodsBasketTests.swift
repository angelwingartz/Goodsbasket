//
//  GoodsBasketTests.swift
//  GoodsBasketTests
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import XCTest
@testable import GoodsBasket

class GoodsBasketTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
    }
    
    func testCurrencyList() {
        let api = CurrencyService.shared()
        let promise = expectation(description: "Currency List API Request")
        api.getCurrencyList { (response) in
            XCTAssertTrue(response["success"] as! Bool == true)
            promise.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCurrencyConversion() {
        let api = CurrencyService.shared()
        let promise = expectation(description: "Currency Conversion Request")
        
        api.getCurrencyValue(amount: 56.11, toCurrency: "CAD") { (result) in
            XCTAssertTrue(result > 0)
            promise.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
