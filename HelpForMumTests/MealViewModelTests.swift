//
//  MealViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 10.11.2024.
//

import XCTest
@testable import HelpForMum

final class MealViewModelTests: XCTestCase {
    
    var vm: MealViewModel?

    override func setUpWithError() throws {
        vm = MealViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_MealViewModel_addMeal() throws {
        
        //Given
        guard let meal_vm = vm else {
            XCTFail()
            return
        }
        
        //When
        let name = UUID().uuidString
        meal_vm.addMeal(name: name)
        let meal = meal_vm.meals[0]
        
        //Then
        XCTAssertTrue(meal_vm.meals.contains(meal))
        
        meal_vm.deleteFromBase(meal: meal)
        
        XCTAssertFalse(meal_vm.meals.contains(meal))
    }
    
    func test_MealViewModel_addMealToFoodIntake() {
        // Given
        guard let meal_vm = vm else {
            XCTFail()
            return
        }
        
        let time_vm = TimeOfFoodViewModel()
        time_vm.addTimes()
        
        let foodIntake_vm = FoodIntakeViewModel()
        let date = Date()
        foodIntake_vm.addFoodIntake(id: UUID().uuidString, time: time_vm.times.randomElement()!, date: date)
        let foodIntake = foodIntake_vm.foodIntakes[0]
        
        let name = UUID().uuidString
        meal_vm.addMeal(name: name)
        let meal = meal_vm.meals[0]
        
        let product_vm = ProductViewModel()
        let nameProd = UUID().uuidString
        let product = product_vm.addProduct(name: nameProd)[0]
        
        product_vm.addProductToMeal(product: product, meal: meal)
        
        
        //When
        meal_vm.addMealToFoodIntake(meal: meal, foodIntake: foodIntake)
        
        //Then
        XCTAssertTrue(foodIntake.products!.contains(product))
        
        meal_vm.deleteFromBase(meal: meal)
        product_vm.deleteFromBase(product: product)
        foodIntake_vm.delete(foodIntake: foodIntake)
        
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
        XCTAssertFalse(meal_vm.meals.contains(meal))
        XCTAssertFalse(product_vm.products.contains(product))
    }
}
