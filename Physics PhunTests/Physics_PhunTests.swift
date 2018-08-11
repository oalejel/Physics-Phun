//
//  Physics_PhunTests.swift
//  Physics PhunTests
//
//  Created by Omar Al-Ejel on 8/11/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import XCTest
@testable import Physics_Phun

class Physics_PhunTests: XCTestCase {
    
    let manager = PhysicistOfTheDayManager()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURLGeneration() {
        // ignore saved name index to start in test
        manager.currentNameIndex = 0
        
//        var generatedURLs = [URL]()
        for index in 0..<manager.names.count {
            let url = manager.getNextURL()
            XCTAssert(url != nil, "got nil for index \(index), name \(manager.names[index])")
//            generatedURLs.append(url!)
        }
        // check to make sure we loop back around
        XCTAssert(manager.currentNameIndex == 0, "current name index ended in \(manager.currentNameIndex)")
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
