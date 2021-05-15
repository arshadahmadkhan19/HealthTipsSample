//
//  TipsListNetworking.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/14/21.
//
import Foundation
import RxSwift

protocol TipsListNetworkingProtocol {
    func getHealthTipsAPIResponse() -> Observable<HealthTipsAPIModel>
}

class TipsListNetworking: TipsListNetworkingProtocol {
    private let networkHandler: NetworkHandler
    init(networkHandler: NetworkHandler) {
        self.networkHandler = networkHandler
    }
    
    func getHealthTipsAPIResponse() -> Observable<HealthTipsAPIModel> {
        var urlRequest = URLRequest(url: URL(string: "https://518406fc-a1bd-44c6-aebe-1585dcc4185c.mock.pstmn.io/getHealthTips")!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json" ]
        return networkHandler.handleAPIRequest(request: urlRequest)
    }
}
