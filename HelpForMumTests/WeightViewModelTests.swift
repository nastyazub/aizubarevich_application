//
//  WeightViewModel.swift
//  HelpForMumTests
//
//  Created by Настя on 10.11.2024.
//

import XCTest
@testable import HelpForMum

final class WeightViewModelTests: XCTestCase {

    var vm: WeightViewModel?

    override func setUpWithError() throws {
        vm = WeightViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_WeightViewModel_addWeight() throws {
        
        //Given
        guard let weight_vm = vm else {
            XCTFail()
            return
        }
        
        //When
        let date = Date()
        let weight = 7.888
        weight_vm.addWeight(weight: weight, date: date)
        var weightEntity = weight_vm.weights[0]
        for weightEnt in weight_vm.weights {
            if weightEnt.weight == weight {
                weightEntity = weightEnt
            }
        }
        
        //Then
        XCTAssertTrue(weight_vm.weights.contains(weightEntity))
        
        weight_vm.delete(weight: weightEntity)
        
        XCTAssertFalse(weight_vm.weights.contains(weightEntity))
    }

}
