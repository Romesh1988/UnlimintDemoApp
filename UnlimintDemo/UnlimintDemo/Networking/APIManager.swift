//
//  APIManager.swift
//  UnlimintDemo
//
//  Created by Romesh Bansal on 29/06/23.
//

import Foundation

enum APIError: Error{
    case httpErrors(Data)
    case mappingFailed
}

enum HTTPMethod: String{
    case get = "get"
    case post = "post"
    case update = "update"
    case delete = "delete"
}



final class APIManager{
    
    static let shared = APIManager()
    private init() {}
    var savedRequest: URLRequest?
    
    
    func performOperation<T:Decodable>(request: URLRequest, response: T.Type) async throws -> T{
        let (serverData, serverUrlResponse) = try await URLSession.shared.data(for:request)
        guard let httpStatusCode = (serverUrlResponse as? HTTPURLResponse)?.statusCode,
              (200...299).contains(httpStatusCode) else {
            throw APIError.httpErrors(serverData)
        }
        return try JSONDecoder().decode(response.self, from: serverData)
    }
}
    
        
    
