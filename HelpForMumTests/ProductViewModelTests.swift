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
        XCTAssertTrue(product_vm.products.contains(product))
        
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
    
    func test_ProductViewModel_sortProductsForFoodIntake() {
        // Given
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
        
        let name1 = UUID().uuidString
        _ = product_vm.addProduct(name: name1)
        let product1 = product_vm.products[0]
        
        let name2 = UUID().uuidString
        _ = product_vm.addProduct(name: name2)
        let product2 = product_vm.products[0]
        
        product_vm.addProductToFoodIntake(product: product1, foodIntake: foodIntake)
        product_vm.addProductToFoodIntake(product: product2, foodIntake: foodIntake)
        
        //When
        let products1 = product_vm.sortProductsForFoodIntake(foodIntake: foodIntake)
        let products2 = foodIntake.products!.allObjects as! [ProductEntity]
        let products2Sorted = products2.sorted() {$0.name! < $1.name!}
        
        //Then
        XCTAssertEqual(products1, products2Sorted)
        
        product_vm.deleteFromBase(product: product1)
        product_vm.deleteFromBase(product: product2)
        foodIntake_vm.delete(foodIntake: foodIntake)
        
        XCTAssertFalse(product_vm.products.contains(product1))
        XCTAssertFalse(product_vm.products.contains(product2))
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
    }
    
    func test_ProductViewModel_deleteFromFoodIntake() {
        
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
        
        product_vm.addProductToFoodIntake(product: product, foodIntake: foodIntake)
        
        // When
        product_vm.deleteFromFoodIntake(product: product, foodIntake: foodIntake)
        
        //Then
        XCTAssertTrue(product_vm.products.contains(product))
        XCTAssertFalse(foodIntake.products!.contains(product))
        
        product_vm.deleteFromBase(product: product)
        foodIntake_vm.delete(foodIntake: foodIntake)
        
        XCTAssertFalse(product_vm.products.contains(product))
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
    }
    
    func test_ProductViewModel_sortProductsForMeal() {
        // Given
        guard let product_vm = vm else {
            XCTFail()
            return
        }
        
        let meal_vm = MealViewModel()
        meal_vm.addMeal(name: UUID().uuidString)
        let meal = meal_vm.meals[0]
        
        let name1 = UUID().uuidString
        _ = product_vm.addProduct(name: name1)
        let product1 = product_vm.products[0]
        
        let name2 = UUID().uuidString
        _ = product_vm.addProduct(name: name2)
        let product2 = product_vm.products[0]
        
        product_vm.addProductToMeal(product: product1, meal: meal)
        product_vm.addProductToMeal(product: product2, meal: meal)
        
        //When
        let products1 = product_vm.sortProductsForMeal(meal: meal)
        let products2 = meal.products!.allObjects as! [ProductEntity]
        let products2Sorted = products2.sorted() {$0.name! < $1.name!}
        
        //Then
        XCTAssertEqual(products1, products2Sorted)
        
        product_vm.deleteFromBase(product: product1)
        product_vm.deleteFromBase(product: product2)
        meal_vm.deleteFromBase(meal: meal)
        
        XCTAssertFalse(product_vm.products.contains(product1))
        XCTAssertFalse(product_vm.products.contains(product2))
        XCTAssertFalse(meal_vm.meals.contains(meal))
    }
    
    func test_ProductViewModel_deleteFromMeal() {
        
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
        
        product_vm.addProductToMeal(product: product, meal: meal)
        
        // When
        product_vm.deleteFromMeal(product: product, meal: meal)
        
        //Then
        XCTAssertTrue(product_vm.products.contains(product))
        XCTAssertFalse(meal.products!.contains(product))
        
        product_vm.deleteFromBase(product: product)
        meal_vm.deleteFromBase(meal: meal)
        
        XCTAssertFalse(product_vm.products.contains(product))
        XCTAssertFalse(meal_vm.meals.contains(meal))
    }
}
