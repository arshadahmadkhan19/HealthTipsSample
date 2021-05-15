//
//  HealthTipsListModel.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/11/21.
//

import Foundation

struct HealthTipsAPIModel: Codable {
    let tips: [Tip]
}

struct Tip: Codable {
    let tipId: String
    let imageURL: String
    let title: String
    let category: String
}
