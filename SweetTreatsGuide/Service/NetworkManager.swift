//
//  NetworkManager.swift
//  SweetTreatsGuide
//
//  Created by Dev on 17/02/2024.
//

import Foundation

struct NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL) async throws -> T {
        do {
            let apiResponse = try await aPIHandler.fetchData(url: url)
            return try await responseHandler.fetchModel(type: type, data: apiResponse)
        } catch {
            throw error
        }
    }
}

protocol APIHandlerDelegate {
    func fetchData(url: URL) async throws -> Data
}

struct APIHandler: APIHandlerDelegate {
    func fetchData(url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ResultType.NoData
            }
            return data
        } catch {
            throw error
        }
    }
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async throws -> T
}

struct ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async throws -> T {
        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch let error as NSError {
            throw error
        }
    }
}
