//
//  HelpForMumTests.swift
//  HelpForMumTests
//
//  Created by Настя on 07.08.2024.
//

import XCTest
@testable import HelpForMum

class TimeOfFoodViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_TimeOfFoodViewModel_addTimes() throws {
        //Given
        let vm = TimeOfFoodViewModel()
        //When
        vm.addTimes()
        //Then
        XCTAssertEqual(vm.times.count, 4)
    }
    
    func test_TimeOfFoodViewModel_addTimes_IfExist() {
        //Given
        let vm = TimeOfFoodViewModel()
        vm.addTimes()
        
        //When
        vm.addTimes()
        
        //Then
        XCTAssertEqual(vm.times.count, 4)
        vm.deleteAll()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
