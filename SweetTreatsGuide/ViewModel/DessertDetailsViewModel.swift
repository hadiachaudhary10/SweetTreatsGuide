//
//  MeakDetailsViewModel.swift
//  SweetTreatsGuide
//
//  Created by Dev on 19/02/2024.
//

import Foundation

@MainActor
class DessertDetailsViewModel: ObservableObject {
    @Published var desertDetails: DessertDetails?
    @Published var result: ResultType = .Fetching
    private var selectedItemID: String
    
    enum displayType {
        case video
        case image
        case none
    }
    
    init(selectedID: String) {
        selectedItemID = selectedID
        fetchDesertDetails()
    }
    
    private func fetchDesertDetails() {
        Task {
            do {
                let mealDetails = try await DessertsService().getDesertDetails(id: selectedItemID)
                self.desertDetails = mealDetails.meals[0]
                self.desertDetails?.strYoutube = self.desertDetails?.strYoutube?.replacingOccurrences(of: "watch?v=", with: "embed/") ?? ""
                result = .Success
            } catch {
                result = .NoData
            }
        }
    }
    
    func updateCheck(id: UUID) {
        if let index = desertDetails?.ingredientsAndMeasures.firstIndex(where: { $0?.id == id }) {
            desertDetails?.ingredientsAndMeasures[index]?.selected.toggle()
        }
    }
    
    func getDisplayTypeURL() -> (url: String, type: displayType) {
        if let url = desertDetails?.strYoutube, url != "" {
            return (url, .video)
        } else if let url = desertDetails?.strMealThumb, url != ""{
            return (url, .image)
        }
        return ("", .none)
    }
}
