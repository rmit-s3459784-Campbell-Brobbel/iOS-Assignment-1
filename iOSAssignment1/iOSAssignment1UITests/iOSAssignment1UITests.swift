//
//  iOSAssignment1UITests.swift
//  iOSAssignment1UITests
//
//  Created by Campbell Brobbel on 19/7/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import XCTest

class iOSAssignment1UITests: XCTestCase {
        
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
        // Use recording to get started writing UI tests.
        
        let pageInd = XCUIApplication().pageIndicators.element(boundBy: 0)
        let todayButton = XCUIApplication().buttons["Today"]
        XCTAssert(pageInd.value as! String == "page 1 of 5")
        pageInd.swipeLeft()
        XCTAssert(pageInd.value as! String == "page 2 of 5")
        pageInd.swipeLeft()
        XCTAssert(pageInd.value as! String == "page 3 of 5")
        todayButton.tap()
        XCTAssert(pageInd.value as! String == "page 1 of 5")
        
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
