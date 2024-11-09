//
//  ProductViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 19.10.2024.
//

import XCTest
@testable import HelpForMum

class ProductViewModelTests: XCTestCase {
    
    var vm: ProductViewModel?
    
    override func setUpWithError() throws {
        vm = ProductViewModel()
    }
    
    override func tearDownWithError() throws {
        vm = nil
    }
    
    func test_ProductViewModel_AddProduct() {
        
        //Given
        guard let product_vm = vm else {
            XCTFail()
            return
        }
        
        let count = product_vm.products.count
        
        //When
        let name = UUID().uuidString
        _ = product_vm.addProduct(name: name)
        let product = product_vm.products[0]
        
        //Then
        XCTAssertEqual(product_vm.products.count, count + 1)
        XCTAssertEqual(product_vm.products[0].name, name)
        product_vm.deleteFromBase(product: product)
        XCTAssertFalse(product_vm.products.contains(product))
    }
    
    func test_ProductViewModel_AddProductToFoodIntake() {
        //Given
        guard let product_vm = vm else {
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
        _ = product_vm.addProduct(name: name)
        let product = product_vm.products[0]
        
        //When
        product_vm.addProductToFoodIntake(product: product, foodIntake: foodIntake)
        
        //Then
        XCTAssertTrue(foodIntake.products!.contains(product))
        product_vm.deleteFromBase(product: product)
        foodIntake_vm.delete(foodIntake: foodIntake)
        XCTAssertFalse(product_vm.products.contains(product))
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
    }
    
    func text_ProductViewModel_AddProductToMeal() {
        //Given
        guard let product_vm = vm else {
            XCTFail()
            return
        }
        
        let meal_vm = MealViewModel()
        meal_vm.addMeal(name: UUID().uuidString)
        let meal = meal_vm.meals[0]
        
        let name = UUID().uuidString
        _ = product_vm.addProduct(name: name)
        let product = product_vm.products[0]
        
        //When
        product_vm.addProductToMeal(product: product, meal: meal)
        
        //Then
        XCTAssertTrue(meal.products!.contains(product))
        product_vm.deleteFromBase(product: product)
        meal_vm.deleteFromBase(meal: meal)
        XCTAssertFalse(product_vm.products.contains(product))
        XCTAssertFalse(meal_vm.meals.contains(meal))
    }
    
//    func test_ProductViewModel_deleteFromFoodIntake() {
//        
//        //Given
//        guard let product_vm = vm else {
//            XCTFail()
//            return
//        }
//        
//        let time_vm = TimeOfFoodViewModel()
//        time_vm.addTimes()
//        
//        let foodIntake_vm = FoodIntakeViewModel()
//        let date = Date()
//        foodIntake_vm.addFoodIntake(id: UUID().uuidString, time: time_vm.times.randomElement()!, date: date)
//        let foodIntake = foodIntake_vm.foodIntakes[0]
//        
//        let name = UUID().uuidString
//        _ = product_vm.addProduct(name: name)
//        let product = product_vm.products[0]
//        
//        product_vm.addProductToFoodIntake(product: product, foodIntake: foodIntake)
//        
//        // When
//        product_vm.deleteFromFoodIntake(at: [0], foodIntake: foodIntake)
//        
//        //Then
//        XCTAssertTrue(product_vm.products.contains(product))
//        XCTAssertFalse(foodIntake.products!.contains(product))
//        
//        product_vm.deleteFromBase(product: product)
//        foodIntake_vm.delete(foodIntake: foodIntake)
//        
//        XCTAssertFalse(product_vm.products.contains(product))
//        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
//    }
    
//    func test_ProductViewModel_deleteFromFoodIntake_TwoProducts() {
//        
//        //Given
//        guard let product_vm = vm else {
//            XCTFail()
//            return
//        }
//        
//        let time_vm = TimeOfFoodViewModel()
//        time_vm.addTimes()
//        
//        let foodIntake_vm = FoodIntakeViewModel()
//        let date = Date()
//        foodIntake_vm.addFoodIntake(id: UUID().uuidString, time: time_vm.times.randomElement()!, date: date)
//        let foodIntake = foodIntake_vm.foodIntakes[0]
//        
//        let name1 = UUID().uuidString
//        _ = product_vm.addProduct(name: name1)
//        let product1 = product_vm.products[0]
//        
//        let name2 = UUID().uuidString
//        _ = product_vm.addProduct(name: name2)
//        let product2 = product_vm.products[0]
//        
//        product_vm.addProductToFoodIntake(product: product1, foodIntake: foodIntake)
//        product_vm.addProductToFoodIntake(product: product2, foodIntake: foodIntake)
//        let indexSet0: IndexSet = [0]
//        
//        
//        // When
//        product_vm.deleteFromFoodIntake(at: indexSet0, foodIntake: foodIntake)
//        
//        //Then
//        XCTAssertTrue(product_vm.products.contains(product1))
//        XCTAssertTrue(product_vm.products.contains(product2))
//        XCTAssertFalse(foodIntake.products!.contains(product1))
//        XCTAssertFalse(foodIntake.products!.contains(product2))
//        
//        product_vm.deleteFromBase(product: product1)
//        product_vm.deleteFromBase(product: product2)
//        foodIntake_vm.delete(foodIntake: foodIntake)
//        
//        XCTAssertFalse(product_vm.products.contains(product1))
//        XCTAssertFalse(product_vm.products.contains(product2))
//        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
//    }
}
