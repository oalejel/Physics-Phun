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
        
        for index in 0..<manager.names.count {
            let url = manager.getNextURL()
            XCTAssert(url != nil, "got nil for index \(index), name \(manager.names[index])")
        }
        // check to make sure we loop back around
        XCTAssert(manager.currentNameIndex == 0, "current name index ended in \(manager.currentNameIndex)")
    }

    // go through all physicist urls and check that the data we get matches the form we expect
    func testJSONCorrectness() {
//        manager.currentNameIndex = 0
//        repeat {
//            print("hello")
//            var completedRequest = false
//            manager.update { (name, desc, url, img) in
//                print(desc)
//                XCTAssert(img != nil)
//                completedRequest = true
//            }
//            while !completedRequest { }
//
//        } while manager.currentNameIndex != 0
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
