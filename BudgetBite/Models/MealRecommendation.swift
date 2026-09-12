//
//  MealRecommendation.swift
//  BudgetBite
//
//  Created by emily zhang on 12/9/2026.
//

import Foundation

/// Domain model for a student budgeting scenario: MealRecommendation stores a meal recommendation and the cost of ingredients the student still needs to buy. costToBuy is the cost of the ingredient the student does not have available
///
/// Business rules:
/// 1. A meal recommendation contains the selected recipe
/// 2. A meal recommendation contains the total cost of ingredients the student does not already have

struct MealRecommendation: Identifiable {
    let recipe: Recipe
    let costToBuy: Double
    
    var id: String {
        recipe.id
    }
}
