//
//  FoodIntakeViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 19.10.2024.
//

import XCTest
@testable import HelpForMum

class FoodIntakeViewModelTests: XCTestCase {
    
    var vm: FoodIntakeViewModel?
    
    override func setUpWithError() throws {
        vm = FoodIntakeViewModel()
    }
    
    override func tearDownWithError() throws {
        vm = nil
    }
    
    func test_FoodIntakeViewModel_addFoodIntake() throws {
        
        //Given
        guard let foodIntake_vm = vm else {
            XCTFail()
            return
        }
        
        let time_vm = TimeOfFoodViewModel()
        time_vm.addTimes()
        
        let foodIntakeCount = vm!.foodIntakes.count
        
        // When
        foodIntake_vm.addFoodIntake(id: UUID().uuidString, time: time_vm.times.randomElement()!, date: Date())
        let foodIntake = vm!.foodIntakes[0]
        
        //Then
        XCTAssertEqual(foodIntake, vm!.foodIntakes[0])
        XCTAssertEqual(vm!.foodIntakes.count, foodIntakeCount + 1)
        
        vm?.delete(foodIntake: foodIntake)
        XCTAssertFalse(vm!.foodIntakes.contains(foodIntake))
        
    }
    
    
}

