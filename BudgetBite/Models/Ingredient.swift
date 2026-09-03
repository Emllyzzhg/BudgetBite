//
//  Ingredient.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
// Domain model for a student budgeting scenario: represents food currently available to a student
// Business rules:
// 1. An ingredient must have a name
// 2. The quantity must be greater than zero
struct Ingredient: Identifiable, Codable {
   
    var id: String = UUID().uuidString
    var name: String
    var quantity: Int = 1
}
