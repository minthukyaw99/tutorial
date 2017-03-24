//
//  AppleTutorialTests.swift
//  AppleTutorialTests
//
//  Created by Min thu Kyaw on 3/8/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import XCTest
@testable import AppleTutorial

class AppleTutorialTests: XCTestCase {
    
    //MARK: Meal Class Test
    
    func testMealInitOnSuccess() {
        
        let zeroMeal = Meal(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroMeal)
        
        let maxMeal = Meal(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(maxMeal)
        
    }
    
    func testMealInitOnFails() {
        
        // Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
}
