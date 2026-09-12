//
//  MealPlanEntry.swift
//  BudgetBite
//
//  Created by emily zhang on 8/9/2026.
//

import Foundation
 
/// Domain model for a student budgeting scenario: MealPlanEntry represents a meal selected by the university student for their meal plan. plannedDate is the date the student is going to eat the meal; recipe is the meal the student has selected, and costToBuy represents the portion of the student's food budget committed to that meal i.e., what they need to buy
///
/// Business rules:
/// 1. A meal plan entry must reference a recipe
/// 2. A meal is assigned to a planned date
/// 3. The cost to buy cannot be negative
/// The committed amount is deducted from the student's remaining food budget when the meal is added to the meal plan.  If a meal is removed from the meal plan, its committed costToBuy should be returned to the student's remaining food budget

struct MealPlanEntry: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var recipe: Recipe
    var plannedDate: Date
    var costToBuy: Double
}
