//
//  RecipeRepository.swift where the recipe repository must be able to load, add, update and delete a recipe
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import Foundation

protocol RecipeRepository {
    var recipes: [Recipe] { get }
    
    func load() -> [Recipe]
    func add(_ recipe: Recipe)
    func update(_ recipe: Recipe)
    func delete(_ recipe: Recipe)
}
