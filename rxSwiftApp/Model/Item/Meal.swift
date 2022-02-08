//
//  Meal.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/19.
//

import Foundation

import RxDataSources

struct Meal{
    let name : String
    let price : Double
}

extension Meal: IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
    
}

struct MealCategory  {
    let name : String
    var items : [Meal]
}

extension MealCategory : AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = Meal
    
    var identity: String {
        return name
    }
    
    
    init(original: MealCategory, items: [Meal]) {
        self = original
        self.items = items
    }
}


struct DaysModel  {
    let name : String
    var items : [String]
}

extension DaysModel : AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = String
    
    var identity: String {
        return name
    }
    
    
    init(original: DaysModel, items: [String]) {
        self = original
        self.items = items
    }
}







class MealManager {
    
    static let shared = MealManager()
    
    
    let categories : [MealCategory] = [
        
        
        MealCategory(name: "Indian", items: [
                                 Meal(name: "Dal Tadka", price: 80.0),
                                 Meal(name: "Paneer Masala", price: 100.0),
                                 Meal(name: "Chicken Handi", price: 80.0),
                                 Meal(name: "Chicken Tandoor", price: 100.0),
                                 Meal(name: "Mutton Masala", price: 80.0),
                                 Meal(name: "Paneer Bhurji", price: 100.0),
                                 Meal(name: "Egg Handi", price: 80.0),
                                 Meal(name: "Egg Masala", price: 100.0)
                                 ]),
        MealCategory(name: "Chinese", items: [
                                 Meal(name: "Chicken Lollipop", price: 80.0),
                                 Meal(name: "Manchurian", price: 100.0),
                                 Meal(name: "Veg Noodles", price: 80.0),
                                 Meal(name: "Chicken Noodles", price: 100.0),
                                 Meal(name: "Soup", price: 80.0),
                                 Meal(name: "Chicken 65", price: 100.0),
        ]),
        MealCategory(name: "Snacks", items: [
                                 Meal(name: "Poha", price: 80.0),
                                 Meal(name: "Upma", price: 100.0),
                                 Meal(name: "Idli", price: 80.0),
                                 Meal(name: "Wada Sambhar", price: 100.0),
                                 Meal(name: "Wada Pav", price: 80.0),
                                 Meal(name: "Tea", price: 100.0),
                                 Meal(name: "Coffee1", price: 80.0),
                                 Meal(name: "Coffee2", price: 80.0),
                                 Meal(name: "Coffee3", price: 80.0),
                                 Meal(name: "Coffee4", price: 80.0),
                                 Meal(name: "Coffee5", price: 80.0),
                                 Meal(name: "Green Tea", price: 100.0)
        ]),
        MealCategory(name: "Test", items: [
                                 Meal(name: "Meal 1", price: 80.0),
                                 Meal(name: "Meal 2", price: 100.0),
                                 Meal(name: "Meal 3", price: 80.0),
                                 Meal(name: "Meal 4", price: 100.0),
                                 Meal(name: "Meal 5", price: 80.0),
                                 Meal(name: "Meal 6", price: 100.0),
                                 Meal(name: "Meal 7", price: 80.0),
                                 Meal(name: "Meal 8", price: 100.0),
                                 Meal(name: "Meal 9", price: 80.0),
                                 Meal(name: "Meal 10", price: 80.0),
                                 Meal(name: "Meal 11", price: 80.0),
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0),
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ]),
        MealCategory(name: "Test", items: [
                            
                                 Meal(name: "Meal 12", price: 80.0),
                                 Meal(name: "Meal 13", price: 80.0),
                                 Meal(name: "Meal 14", price: 80.0)
        ])
    ]
    
}
