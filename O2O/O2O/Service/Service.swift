//
//  Service.swift
//  O2O
//
//  Created by Oscar Rodriguez Garrucho on 7/2/23.
//

import Foundation


protocol ServiceProtocol {
    func fetch<T: Decodable>(_ type:ServiceType, textSearch: String, completion: @escaping (ResultResponse<T>) -> Void)
}

final class Service:ServiceProtocol {
    
    func fetch<T: Decodable>(_ type: ServiceType, textSearch: String, completion: @escaping (ResultResponse<T>) -> Void) {
        guard let url = URL(string: type.urlString + textSearch) else {
            completion(.failure(.badURL))
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.init(message: error?.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.invalidJSON))
                return
            }
            
            completion(.success(decoded))
        }
        task.resume()
    }
    
}
