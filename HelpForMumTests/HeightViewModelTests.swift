//
//  HeightViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 10.11.2024.
//

import XCTest
@testable import HelpForMum

final class HeightViewModelTests: XCTestCase {
    
    var vm: HeightViewModel?

    override func setUpWithError() throws {
        vm = HeightViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_HeightViewModel_addHeight() throws {
        
        //Given
        guard let height_vm = vm else {
            XCTFail()
            return
        }
        
        //When
        let height = 156
        let date = Date()
        height_vm.addHeight(height: height, date: date)
        var heightEntity = height_vm.heights[0]
        for heightEnt in height_vm.heights {
            if heightEnt.height == height {
                heightEntity = heightEnt
            }
        }
        
        //Then
        XCTAssertTrue(height_vm.heights.contains(heightEntity))
        
        height_vm.delete(height: heightEntity)
        
        XCTAssertFalse(height_vm.heights.contains(heightEntity))
    }
}
