//
//  HelpForMumTests.swift
//  HelpForMumTests
//
//  Created by Настя on 07.08.2024.
//

import XCTest
@testable import HelpForMum

class TimeOfFoodViewModelTests: XCTestCase {
    
    var vm: TimeOfFoodViewModel?

    override func setUpWithError() throws {
        vm = TimeOfFoodViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }
    
    func test_TimeOfFoodViewModel_addTimes() throws {
        //Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        //When
        vm.addTimes()
        
        //Then
        XCTAssertFalse(vm.times.isEmpty)
        XCTAssertEqual(vm.times.count, 4)
    }
    
    func test_TimeOfFoodViewModel_addTimes_IfExist() {
        //Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        vm.addTimes()
        
        //When
        vm.addTimes()
        
        //Then
        XCTAssertEqual(vm.times.count, 4)
    }
}
