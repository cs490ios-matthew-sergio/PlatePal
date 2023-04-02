//
//  Meal.swift
//  PlatePal
//
//  Created by user233480 on 4/1/23.
//

import Foundation

import ParseSwift

// TODO: Pt 1 - Create Post Parse Object model


struct Meal {
    // These are required by ParseObject
    let mealName: String
    let mealCal: String
    let mealPro: String
    let mealCar: String
    let mealFat: String
}

extension Meal {

    /// An array of mock tracks
    static var mockMeals: [Meal]  = [
        Meal(mealName: "Breakfast",
              mealCal: "684",
              mealPro: "50g",
              mealCar: "100g",
              mealFat: "50g"),
        Meal(mealName: "Lunch",
              mealCal: "1200",
              mealPro: "72g",
              mealCar: "125g",
              mealFat: "20g"),
        Meal(mealName: "Dinner",
              mealCal: "1025",
              mealPro: "86g",
              mealCar: "132g",
              mealFat: "42g"),
        Meal(mealName: "Snack",
              mealCal: "1025",
              mealPro: "86g",
              mealCar: "132g",
              mealFat: "42g"),
    ]

    // We can now access this array of mock tracks anywhere like this:
    // let tracks = Tracks.mockTracks
}
