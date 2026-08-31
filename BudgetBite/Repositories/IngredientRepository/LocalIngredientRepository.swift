//
//  LocalIngredientRepository.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import Foundation

class LocalIngredientRepository: IngredientRepository {
    private(set) var ingredients: [Ingredient] = []
    
    init() {
        ingredients = load()
    }
    
    func load() -> [Ingredient] {
        let localIngredients = [
            Ingredient(name: "Egg", quantity: 6),
            Ingredient(name: "Rice", quantity: 1), //what does 1 mean here?
            Ingredient(name: "Carrots", quantity: 3)
        ]
        
        return localIngredients
    }
    
    func add(_ ingredient: Ingredient) {
        ingredients.append(ingredients)
    }
    
    func update(_ ingredient: Ingredient) {
        guard let index = ingredients.firstIndex(where: { $0.id == ingredient.id }) else { return }
        
        recipes[index] = recipe
    }
    
    func delete(_ ingredient: Ingredient) {
        guard let index = ingredient.firstIndex(where: { $0.id == ingredient.id }) else { return }
        
        ingredients.remove(at: index)
    }
}
