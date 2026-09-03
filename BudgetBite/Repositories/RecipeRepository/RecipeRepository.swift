//
//  RecipeRepository.swift for how recipe data is stored/managed
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
