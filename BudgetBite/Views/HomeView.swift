//
//  HomeView.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import SwiftUI

struct HomeView: View {
   
    @EnvironmentObject private var budgetViewModel: BudgetViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Remaining Food Budget")
                    .font(.headline)
                
                
            }
        }
    }
}

#Preview {
    HomeView()
}
