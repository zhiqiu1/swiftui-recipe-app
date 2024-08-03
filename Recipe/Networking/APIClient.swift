//
//  APIClient.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/3/24.
//

import Foundation

class APIClient {
    func fetchData<T: Decodable>(from urlString: String, decodingType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(decodingType, from: data)
        return decodedResponse
    }
}
