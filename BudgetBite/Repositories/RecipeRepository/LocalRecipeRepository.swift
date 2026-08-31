//
//  LocalRecipeRepository.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import Foundation

class LocalRecipeRepository: RecipeRepository {
    private(set) var recipes: [Recipe] = []
    
    init() {
        recipes = load()
    }
    
    func load() -> [Recipe] {
        let localRecipes = [
            Recipe(name: "Egg Fried Rice", ingredients: ["Rice", "Egg", "Carrot"], estimatedCost: 4.50),
            Recipe(name: "Chicken Rice Bowl", ingredients: ["Chicken", "Rice", "Carrot"], estimatedCost: 5.50),
            Recipe(name: "Vegetable Pasta", ingredients: ["Pasta", "Tomato", "Carrot"], estimatedCost: 4.00)
        ]
        
        return localRecipes
    }
    
    func add(_ recipe: Recipe) {
        recipes.append(recipe)
    }
    
    func update(_ recipe: Recipe) {
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else { return }
        
        recipes[index] = recipe
    }
    
    func delete(_ recipe: Recipe) {
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else { return }
        
        recipes.remove(at: index)
    }
}
