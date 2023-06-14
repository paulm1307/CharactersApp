//
//  NetworkManager.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/13/23.
//

import Foundation
import Combine

protocol NetworkManagerType {
    func getModel<T: Decodable>(request: URLRequest?) -> AnyPublisher<T, NetworkError>
    func getData(request: URLRequest?) -> AnyPublisher<Data, NetworkError>
}

class NetworkManager: NetworkManagerType {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func getModel<T>(request: URLRequest?) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        guard let request = request else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: request)
            .tryMap { map in
                if let httpResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.invalidStatusCode(httpResponse.statusCode)
                }
                return map.data
            }.decode(type: T.self, decoder: self.decoder)
            .mapError { error in
                if let decodeError = error as? DecodingError {
                    return NetworkError.decodeError(decodeError)
                }
                return NetworkError.unknownError
            }.eraseToAnyPublisher()
        
    }
    
    func getData(request: URLRequest?) -> AnyPublisher<Data, NetworkError> {
        
        guard let request = request else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: request)
            .tryMap { map in
                if let httpResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.invalidStatusCode(httpResponse.statusCode)
                }
                return map.data
            }
            .mapError { error in
                return NetworkError.unknownError
            }.eraseToAnyPublisher()
    }
    
}
