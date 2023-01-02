//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sevval Alev on 1.01.2023.
//

import Foundation

final class RMRequest {

    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    /// Desired endpoint
    private let endPoint: RMEndpoint
    /// Path components for API, if any
    private let pathComponents: [String]
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    /// Desired http method
    public let httpMethod = "GET"
    
    //MARK: - Public
    
    /// Construct request
    /// - Parameters:
    ///   - endPoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    init(endPoint: RMEndpoint,
         pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endPoint: .character)
}
