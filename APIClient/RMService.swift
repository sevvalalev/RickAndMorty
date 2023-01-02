//
//  RMService.swift
//  RickAndMorty
//
//  Created by Sevval Alev on 1.01.2023.
//

import Foundation

final class RMService {
    //shared singleton
    static let shared = RMService()
    //privatized constructor
    private init() {}

    enum RMServiceError: Error {
        case failedToCreatRequest
        case failedToGetData
    }
    //send rick and morty api call
    /// API Call
    /// - Parameters:
    ///   - request: request instance
    ///   - type: the type of object we expect to get back
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreatRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            //decode response
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: - Private
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
