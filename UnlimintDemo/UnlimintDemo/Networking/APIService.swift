//
//  APIService.swift
//  UnlimintDemo
//
//  Created by Romesh Bansal on 29/06/23.
//

import Foundation

class APIService{
    
    public func callAPIGetJokes(onSuccess successCallback: ((_ joke: Joke) -> Void)?,
                                onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        Task{
            var urlRequest = URLRequest(url: URL(string: APIEndpoints.getJokesURLPath())!)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            do{
                let joke = try await APIManager.shared.performOperation(request: urlRequest, response: Joke.self)
                successCallback?(joke)
            }catch let APIError.httpErrors(data){
                let message = self.getMessageFromFailure(data: data)
                failureCallback?(message)
            }catch let error{
                failureCallback?(error.localizedDescription)
            }
        }
    }
    
    func getMessageFromFailure(data: Data)->String{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            if let message = json?["message"] as? String{
                return message
            }
        }catch {
            
        }
        return ""
    }
}
