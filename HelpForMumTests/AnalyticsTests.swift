//
//  AnalyticsViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 10.11.2024.
//

import XCTest
@testable import HelpForMum

final class AnalyticsTests: XCTestCase {
    
    var vm: Analytics?

    override func setUpWithError() throws {
        vm = Analytics()
    }

    override func tearDownWithError() throws {
        vm = Analytics()
    }

    func test_Analytics_countAll() throws {
        
        //Given
        guard let analytics_vm = vm else {
            XCTFail()
            return
        }
        
        let foodIntake_vm = FoodIntakeViewModel()
        let product_vm = ProductViewModel()
        let reaction_vm = ReactionViewModel()
        
        let time_vm = TimeOfFoodViewModel()
        time_vm.addTimes()
        
        let date1 = Date()
        let idFood1 = UUID().uuidString
        foodIntake_vm.addFoodIntake(id: idFood1, time: time_vm.times[0], date: date1)
        
        let date2 = Date()
        let idFood2 = UUID().uuidString
        foodIntake_vm.addFoodIntake(id: idFood2, time: time_vm.times[1], date: date2)
        var count = 0
        var foodIntake1 = foodIntake_vm.foodIntakes[0]
        var foodIntake2 = foodIntake_vm.foodIntakes[0]
        
        for foodIntake in foodIntake_vm.foodIntakes {
            if foodIntake.id == idFood1 {
                foodIntake1 = foodIntake
                count += 1
            }
            if foodIntake.id == idFood2 {
                foodIntake2 = foodIntake
                count += 1
            }
            if count == 2 {
                break
            }
        }
        
        let nameProd1 = UUID().uuidString
        let nameProd2 = UUID().uuidString
        let nameProd3 = UUID().uuidString
        let nameProd4 = UUID().uuidString
        
        let product1 = product_vm.addProduct(name: nameProd1)[0]
        let product2 = product_vm.addProduct(name: nameProd2)[0]
        let product3 = product_vm.addProduct(name: nameProd3)[0]
        let product4 = product_vm.addProduct(name: nameProd4)[0]
        
        let nameReact = UUID().uuidString
        reaction_vm.addReaction(name: UUID().uuidString)
        var reaction = reaction_vm.reactions[0]
        
        for Areaction in reaction_vm.reactions {
            if nameReact == Areaction.name {
                reaction = Areaction
                break
            }
        }
        
        product_vm.addProductToFoodIntake(product: product1, foodIntake: foodIntake1)
        product_vm.addProductToFoodIntake(product: product2, foodIntake: foodIntake1)
        product_vm.addProductToFoodIntake(product: product3, foodIntake: foodIntake1)
        product_vm.addProductToFoodIntake(product: product4, foodIntake: foodIntake2)
        product_vm.addProductToFoodIntake(product: product4, foodIntake: foodIntake1)
        
        reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake1)
        reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake2)
        
        // When
        let countAll = analytics_vm.countAll(reaction: reaction)
        
        //Then
        XCTAssertEqual(countAll, 5)
        
        product_vm.deleteFromBase(product: product1)
        product_vm.deleteFromBase(product: product2)
        product_vm.deleteFromBase(product: product3)
        product_vm.deleteFromBase(product: product4)
        
        foodIntake_vm.delete(foodIntake: foodIntake1)
        foodIntake_vm.delete(foodIntake: foodIntake2)
        
        reaction_vm.deleteFromBase(reaction: reaction)
        
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains([foodIntake1, foodIntake2]))
        XCTAssertFalse(product_vm.products.contains([product1, product2, product3, product4]))
        XCTAssertFalse(reaction_vm.reactions.contains(reaction))
    }
    
    func test_Analytics_countForProduct() {
        
        //Given
        guard let analytics_vm = vm else {
            XCTFail()
            return
        }
        
        let foodIntake_vm = FoodIntakeViewModel()
        let product_vm = ProductViewModel()
        let reaction_vm = ReactionViewModel()
        
        let time_vm = TimeOfFoodViewModel()
        time_vm.addTimes()
        
        let date1 = Date()
        let idFood1 = UUID().uuidString
        foodIntake_vm.addFoodIntake(id: idFood1, time: time_vm.times[0], date: date1)
        
        let date2 = Date()
        let idFood2 = UUID().uuidString
        foodIntake_vm.addFoodIntake(id: idFood2, time: time_vm.times[1], date: date2)
        var count = 0
        var foodIntake1 = foodIntake_vm.foodIntakes[0]
        var foodIntake2 = foodIntake_vm.foodIntakes[0]
        
        for foodIntake in foodIntake_vm.foodIntakes {
            if foodIntake.id == idFood1 {
                foodIntake1 = foodIntake
                count += 1
            }
            if foodIntake.id == idFood2 {
                foodIntake2 = foodIntake
                count += 1
            }
            if count == 2 {
                break
            }
        }
        
        let nameProd1 = UUID().uuidString
        let nameProd2 = UUID().uuidString
        let nameProd3 = UUID().uuidString
        let nameProd4 = UUID().uuidString
        
        let product1 = product_vm.addProduct(name: nameProd1)[0]
        let product2 = product_vm.addProduct(name: nameProd2)[0]
        let product3 = product_vm.addProduct(name: nameProd3)[0]
        let product4 = product_vm.addProduct(name: nameProd4)[0]
        
        let nameReact = UUID().uuidString
        reaction_vm.addReaction(name: UUID().uuidString)
        var reaction = reaction_vm.reactions[0]
        
        for Areaction in reaction_vm.reactions {
            if nameReact == Areaction.name {
                reaction = Areaction
                break
            }
        }
        
        product_vm.addProductToFoodIntake(product: product1, foodIntake: foodIntake1)
        product_vm.addProductToFoodIntake(product: product2, foodIntake: foodIntake1)
        product_vm.addProductToFoodIntake(product: product3, foodIntake: foodIntake1)
        product_vm.addProductToFoodIntake(product: product4, foodIntake: foodIntake2)
        product_vm.addProductToFoodIntake(product: product4, foodIntake: foodIntake1)
        
        reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake1)
        reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake2)
        
        // When
        let countForProduct = analytics_vm.countForProduct(reaction: reaction)
        
        //Then
        XCTAssertEqual(countForProduct.count, 4)
        XCTAssertEqual(countForProduct.first?.key, product4)
        XCTAssertEqual(countForProduct.first?.value, 2)
        
        product_vm.deleteFromBase(product: product1)
        product_vm.deleteFromBase(product: product2)
        product_vm.deleteFromBase(product: product3)
        product_vm.deleteFromBase(product: product4)

        foodIntake_vm.delete(foodIntake: foodIntake1)
        foodIntake_vm.delete(foodIntake: foodIntake2)
        
        reaction_vm.deleteFromBase(reaction: reaction)
        
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains([foodIntake1, foodIntake2]))
        XCTAssertFalse(product_vm.products.contains([product1, product2, product3, product4]))
        XCTAssertFalse(reaction_vm.reactions.contains(reaction))
    }
}
