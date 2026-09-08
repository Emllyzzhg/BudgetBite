//
//  MealPlanEntry.swift
//  BudgetBite
//
//  Created by emily zhang on 8/9/2026.
//

import Foundation
 
/// Domain model for a student budgeting scenario: MealPlanEntry represents a meal selected by the university student for their meal plan. plannedDate is the date the student is going to eat the meal
///
/// Business rules:
/// 1. A meal plan entry must reference a recipe
/// 2. A meal is assigned to a planned date

struct MealPlanEntry: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var recipeID: String
    var plannedDate: Date
}
