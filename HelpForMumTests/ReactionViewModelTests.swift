//
//  ReactionViewModelTests.swift
//  HelpForMumTests
//
//  Created by Настя on 10.11.2024.
//

import XCTest
@testable import HelpForMum

final class ReactionViewModelTests: XCTestCase {
    
    var vm: ReactionViewModel?

    override func setUpWithError() throws {
        vm = ReactionViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_ProductViewModel_AddProduct() {
        
        //Given
        guard let reaction_vm = vm else {
            XCTFail()
            return
        }
        
        let count = reaction_vm.reactions.count
        
        //When
        let name = UUID().uuidString
        reaction_vm.addReaction(name: name)
        let reaction = reaction_vm.reactions[0]
        
        //Then
        XCTAssertEqual(reaction_vm.reactions.count, count + 1)
        XCTAssertTrue(reaction_vm.reactions.contains(reaction))
        
        reaction_vm.deleteFromBase(reaction: reaction)
        
        XCTAssertFalse(reaction_vm.reactions.contains(reaction))
    }
    
    func test_ProductViewModel_AddProductToFoodIntake() {
        //Given
        guard let reaction_vm = vm else {
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
        reaction_vm.addReaction(name: name)
        let reaction = reaction_vm.reactions[0]
        
        //When
        reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake)
        
        //Then
        XCTAssertTrue(foodIntake.reactions!.contains(reaction))
        
        reaction_vm.deleteFromBase(reaction: reaction)
        foodIntake_vm.delete(foodIntake: foodIntake)
        
        XCTAssertFalse(reaction_vm.reactions.contains(reaction))
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
    }
    
    func test_ProductViewModel_sortProductsForFoodIntake() {
        // Given
        guard let reaction_vm = vm else {
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
        reaction_vm.addReaction(name: name1)
        let reaction1 = reaction_vm.reactions[0]
        
        let name2 = UUID().uuidString
        reaction_vm.addReaction(name: name2)
        let reaction2 = reaction_vm.reactions[0]
        
        reaction_vm.addReactionToFoodIntake(reaction: reaction1, foodIntake: foodIntake)
        reaction_vm.addReactionToFoodIntake(reaction: reaction2, foodIntake: foodIntake)
        
        //When
        let reactions1 = reaction_vm.sortReactionsForFoodIntake(foodIntake: foodIntake)
        let reactions2 = foodIntake.reactions!.allObjects as! [ReactionEntity]
        let reactions2Sorted = reactions2.sorted() {$0.name! < $1.name!}
        
        //Then
        XCTAssertEqual(reactions1, reactions2Sorted)
        
        reaction_vm.deleteFromBase(reaction: reaction1)
        reaction_vm.deleteFromBase(reaction: reaction2)
        foodIntake_vm.delete(foodIntake: foodIntake)
        
        XCTAssertFalse(reaction_vm.reactions.contains(reaction1))
        XCTAssertFalse(reaction_vm.reactions.contains(reaction2))
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
    }
    
    func test_ProductViewModel_deleteFromFoodIntake() {
        
        //Given
        guard let reaction_vm = vm else {
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
        reaction_vm.addReaction(name: name)
        let reaction = reaction_vm.reactions[0]
        
        reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake)
        
        // When
        reaction_vm.deleteFromFoodIntake(reaction: reaction, foodIntake: foodIntake)
        
        //Then
        XCTAssertTrue(reaction_vm.reactions.contains(reaction))
        XCTAssertFalse(foodIntake.reactions!.contains(reaction))
        
        reaction_vm.deleteFromBase(reaction: reaction)
        foodIntake_vm.delete(foodIntake: foodIntake)
        
        XCTAssertFalse(reaction_vm.reactions.contains(reaction))
        XCTAssertFalse(foodIntake_vm.foodIntakes.contains(foodIntake))
    }
}
