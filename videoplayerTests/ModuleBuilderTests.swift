//
//  ModuleBuilderTests.swift
//  videoplayerTests
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest
@testable import videoplayer

class ModuleBuilderTests: XCTestCase {
    var builder: ModuleBuilder?
    
    override func setUp() {
        super.setUp()
        builder = ModuleBuilder()
    }
    
    override func tearDown() {
        builder = nil
        super.tearDown()
    }
    
    func testEmpty() {
        XCTAssertNil(builder?.view, "view is not nil")
        XCTAssertNil(builder?.presenter, "presenter is not nil")
    }
    func testBuild() {
        let input = View()
        let presenter = Presenter()
        builder?.add(view: input)
        XCTAssertNotNil(builder?.view, "view is nil")
        builder?.add(presenter: presenter)
        XCTAssertNotNil(builder?.presenter, "presenter is nil")
        let output = builder?.build()
        XCTAssertNotNil(output)
        XCTAssertTrue(output == input, "Views don\t match")
        
        
        XCTAssertTrue((output!.dataSource as! Presenter) == presenter, "dataSource not set correctly")
//        XCTAssertTrue(builder!.presenter == presenter, "dataSource not set correctly")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
