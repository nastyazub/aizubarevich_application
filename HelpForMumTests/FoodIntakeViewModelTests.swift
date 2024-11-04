//
//  FoodIntakeViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 19.10.2024.
//

import XCTest
@testable import HelpForMum

class FoodIntakeViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func test_addFoodIntake_saves() throws{
//        //Given
//        let food_vm = FoodIntakeViewModel()
//        let time_vm = TimeOfFoodViewModel()
//        let date = Date()
//        time_vm.addTimes()
//        food_vm.deleteAll()
//        let list = [
//            "Завтрак", "Обед", "Полдник", "Ужин"
//        ]
//        
//        let id = UUID().uuidString
//        let name = list.randomElement()
//        time_vm.getTimeForFoodIntake(title: name ?? "")
//        
//        let time =  time_vm.times[0]
//        
//        //When
//        food_vm.addFoodIntake(id: id, time: time, date: date)
//        
//        //Then
//        XCTAssertEqual(food_vm.foodIntakes.count, 1)
//        XCTAssertEqual(food_vm.foodIntakes[0].id, id)
//        XCTAssertEqual(food_vm.foodIntakes[0].type_of_time, time)
//        XCTAssertEqual(time_vm.times[0].name, name)
//        food_vm.delete(foodIntake: food_vm.foodIntakes[0])
//        XCTAssertTrue(food_vm.foodIntakes.isEmpty)
//        
//    }
    
    func test_deleting() {
        let vm = FoodIntakeViewModel()
        vm.deleteAll()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

