//
//  Budget.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
// Domain model for a student budgeting scenario: represents a student's available food budget for the week
// Business rules:
// 1. The remaining budget cannot be greater than the weekly budget
// 2. The remaining budget cannot be negative
struct Budget: Identifiable, Codable {
   
    var id: String = UUID().uuidString
    var weeklyBudget: Double
    var remainingBudget: Double
}
