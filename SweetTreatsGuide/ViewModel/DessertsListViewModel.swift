//
//  MealsListViewModel.swift
//  SweetTreatsGuide
//
//  Created by Dev on 17/02/2024.
//

import Foundation

@MainActor
class DessertsListViewModel: ObservableObject {
    @Published var deserts: [Deserts] = []
    @Published var result: ResultType = .Fetching
    
    init() {
        fetchDesertsList()
    }
    
    private func fetchDesertsList() {
        Task {
            do {
                let mealsList = try await DessertsService().getDesertsList()
                self.deserts = mealsList.meals.sorted {$0.strMeal < $1.strMeal}
                result = .Success
            } catch {
                result = .NoData
            }
        }
    }
}
