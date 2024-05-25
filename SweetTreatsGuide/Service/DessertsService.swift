//
//  File.swift
//  SweetTreatsGuide
//
//  Created by Dev on 17/02/2024.
//

import Foundation

struct DessertsService {
    func getDesertsList() async throws -> DesertsListModel  {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw ResultType.NoData
        }
        do {
            return try await NetworkManager().fetchRequest(type: DesertsListModel.self, url: url)
        } catch let error as NSError {
            throw error
        }
    }
    func getDesertDetails(id: String) async throws -> DessertDetailsList {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=" + id) else {
            throw ResultType.NoData
        }
        do {
            return try await NetworkManager().fetchRequest(type: DessertDetailsList.self, url: url)
        } catch let error as NSError {
            throw error
        }
    }
}
