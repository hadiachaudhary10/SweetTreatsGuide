//
//  MealDetailsModel.swift
//  SweetTreatsGuide
//
//  Created by Dev on 18/02/2024.
//

import Foundation

struct DessertDetailsList: Codable {
    let meals: [DessertDetails?]
}

struct DessertDetails: Codable {
    var idMeal: String?
    var strMeal: String?
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strYoutube: String?
    var ingredientsAndMeasures: [IngredientAndMeasure?]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDict = try container.decode([String: String?].self)
        var index = 1
        var ingredientsAndMeasuresArray = [IngredientAndMeasure]()
        self.idMeal = mealDict["idMeal"] as? String
        self.strMeal = mealDict["strMeal"] as? String
        self.strArea = mealDict["strArea"] as? String
        self.strInstructions = mealDict["strInstructions"] as? String
        self.strMealThumb = mealDict["strMealThumb"] as? String
        self.strYoutube = mealDict["strYoutube"] as? String
        
        while true {
            guard
                let ingredient = mealDict["strIngredient\(index)"] as? String,
                let measure = mealDict["strMeasure\(index)"] as? String
            else {
                break
            }
            if !ingredient.isEmpty && !measure.isEmpty {
                ingredientsAndMeasuresArray.append(IngredientAndMeasure(ingredientName: ingredient, ingredientMeasure :measure, selected: false))
            }
            index += 1
        }
        self.ingredientsAndMeasures = ingredientsAndMeasuresArray
    }
}

struct IngredientAndMeasure: Hashable, Identifiable, Encodable {
    var ingredientName: String
    var ingredientMeasure: String
    var selected: Bool
    var id = UUID()
    
    init(ingredientName: String, ingredientMeasure: String, selected: Bool) {
        self.ingredientName = ingredientName
        self.ingredientMeasure = ingredientMeasure
        self.selected = selected
    }
}
