//
//  TipsListViewModel.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/14/21.
//

import Foundation
import RxSwift

protocol TipsListViewModelProtocol {
    func getTipsListResponse() -> Observable<[TipsListCellModel]>
}

class TipsListViewModel: TipsListViewModelProtocol {
    private let tipsListNetworking: TipsListNetworkingProtocol
    init(tipsListNetworking: TipsListNetworkingProtocol) {
        self.tipsListNetworking = tipsListNetworking
    }
    func getTipsListResponse() -> Observable<[TipsListCellModel]> {
        tipsListNetworking
            .getHealthTipsAPIResponse()
            .map { apiModel -> [TipsListCellModel] in
                apiModel.tips.map { tip  -> TipsListCellModel in
                TipsListCellModel(imageUrl: tip.imageURL, category: tip.category, title: tip.title)
            }
        }
    }
}

struct TipsListCellModel {
    let imageUrl: String
    let category: String
    let title: String
}
