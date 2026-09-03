//
//  IngredientRepository.swift for student's ingredients data is stored/managed
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import Foundation

protocol IngredientRepository {
    var ingredients: [Ingredient] { get }
    
    func load() -> [Ingredient]
    func add(_ ingredient: Ingredient)
    func update(_ ingredient: Ingredient)
    func delete(_ ingredient: Ingredient)
}
