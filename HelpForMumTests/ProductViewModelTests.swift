//
//  ProductViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 19.10.2024.
//

import XCTest
@testable import HelpForMum

class ProductViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func test_addProduct_saves() throws {
//        //Given
//        let vm = ProductViewModel()
//        let name = "Food"
//        let count = vm.products.count
//        
//        //When
//        vm.addProduct(name: name)
//        
//        //Then
//        XCTAssertEqual(vm.products.count, count + 1)
//        vm.searchProductName(name: name)
//        XCTAssertEqual(vm.products[0].name, name)
//        vm.deleteFromBase(product: vm.products[0])
//    }
    
//    func test_addProductToTime() throws {
//        //Given
//        let food_vm = FoodIntakeViewModel()
//        let time_vm = TimeOfFoodViewModel()
//        let product_vm = ProductViewModel()
//        
//        let id = UUID().uuidString
//        
//        let list = [
//            "Завтрак", "Обед", "Полдник", "Ужин"
//        ]
//        
//        let nameOfFoodIntake = list.randomElement()
//        
//        time_vm.getTimeForFoodIntake(title: nameOfFoodIntake ?? "")
//        let time =  time_vm.times[0]
//        
//        let date = Date()
//        
//        food_vm.addFoodIntake(id: id, time: time, date: date)
//        food_vm.searchFoodIntakeId(id: id)
//        
//        let nameOfProduct = "Food"
//        product_vm.addProduct(name: nameOfProduct)
//        
//        //When
//        product_vm.addProductToTime(product: product_vm.products[0], foodIntake: food_vm.foodIntakes[0])
//        let products = food_vm.foodIntakes[0].products?.allObjects as! [ProductEntity]
//        
//        //Then
//        XCTAssertEqual(products.count, 1)
//        XCTAssertEqual(products[0].name, nameOfProduct)
//        food_vm.delete(foodIntake: food_vm.foodIntakes[0])
//    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
