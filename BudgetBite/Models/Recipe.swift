//
//  Recipe.swift
//  BudgetBite
//
//  Created by emily zhang on 8/9/2026.
//

import Foundation
 
/// Domain model for a student budgeting scenario: Recipe represents a meal the university student can prepare. ingredients is the ingredients needed to prepare the meal, estimatedCost is the estimated additional cost to prepare the meal
///
/// Business rules:
/// 1. A recipe must contain at least one ingredient
/// 2. The estimated cost cannot be negative
/// 3. A recipe can only be recommended when its estimated cost is within the student's remaining budget

struct RecipeIngredient: Codable {
    var name: String
    var price: Double
}

struct Recipe: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var name: String
    var ingredients: [RecipeIngredient]
    var estimatedCost: Double
}
