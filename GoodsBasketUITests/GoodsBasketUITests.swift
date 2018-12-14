//
//  GoodsBasketUITests.swift
//  GoodsBasketUITests
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import XCTest

class GoodsBasketUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //This will test if we haven't added any items to the basket and we're trying to
    //checkout so an alert should be presented to inform that there are no items in the basket
    func testEmptyBasket(){
        
        addUIInterruptionMonitor(withDescription: "Empty Basket") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Checkout"].tap()
        app.buttons["basket"].tap()
    }
    //This will test when adding items to the basket
    //The checkout screen will be presented then it's OK passed
    func testAddToBasket(){
        
        addUIInterruptionMonitor(withDescription: "Empty Basket") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["itemCellPlus_0"].tap()
        app.buttons["itemCellPlus_1"].tap()
        app.buttons["itemCellPlus_2"].tap()
        app.buttons["itemCellPlus_2"].tap()
        app.buttons["itemCellPlus_3"].tap()
        app.buttons["Checkout"].tap()
    }
    
    //This will test if we see the Canadian Dollar currency in the list
    //then it will select it and the total should change to the
    //selected currency and the exchange rate
    func testChangeCurrencyAtCheckout(){
        let app = XCUIApplication()
        app.buttons["itemCellPlus_3"].tap()
        app.buttons["Checkout"].tap()
        app.buttons["Change currency €"].tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Canadian Dollar")
        app.buttons["Done"].tap()
    }
}
