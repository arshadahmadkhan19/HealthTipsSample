//
//  NetworkHandler.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/11/21.
//
import Foundation
import RxSwift
import RxCocoa

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

enum HealthTipsEndpoint: Endpoint {
    case getHealthTips
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "518406fc-a1bd-44c6-aebe-1585dcc4185c.mock.pstmn.io"
    }
    
    var path: String {
        switch self {
            case .getHealthTips:
                return "getHealthTips"
        }
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var method: String {
        switch self {
            case .getHealthTips:
                return "GET"
        }
    }
}

class NetworkHandler {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    // handle request using RxCocoa
     func handleAPIRequest<T: Codable>(request: URLRequest) -> Observable<T> {
        return session.rx.response(request: request)
            .map { response, data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
    // handle request using URLSession datatask
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping(Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url  else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(decodedData))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
