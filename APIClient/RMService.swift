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
    //send rick and morty api call
    /// API Call
    /// - Parameters:
    ///   - request: request instance
    ///   - type: the type of object we expect to get back
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}
