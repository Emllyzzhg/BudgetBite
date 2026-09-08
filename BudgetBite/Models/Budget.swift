//
//  Budget.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
/// Domain model for a student budgeting scenario: Budget represents a student's available food budget for the week. weeklyBudget is the amount the student has allocated for food for the week; remainingBudget is the amount still available to spend
///
/// Business rules:
/// 1. The remaining budget cannot be greater than the weekly budget
/// 2. The remaining budget cannot be negative
/// 3. Spending reduces the remaining budget

struct Budget: Identifiable, Codable {
   
    var id: String = UUID().uuidString
    var weeklyBudget: Double
    var remainingBudget: Double
}
