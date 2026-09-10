//
//  Ingredient.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
/// Domain model for a student budgeting scenario: Ingredient represents food currently available to a student. name refers to the type of food the student has available; quantity is how much of that ingredient the student currently has
///
/// Business rules:
/// 1. The quantity must be greater than zero
/// 2. The student can increase or decrease the quantity

struct Ingredient: Identifiable, Codable {
   
    var id: String = UUID().uuidString
    var name: String
    var quantity: Int = 1
}
