//
//  TipsListNetworkingTests.swift
//  HealthTipsTests
//
//  Created by Arshad Khan on 4/24/21.
//

import RxSwift
import XCTest
@testable import HealthTips

class TipsListNetworkingTests: XCTestCase {
    var subject: TipsListNetworking!
    var mockNetworkHandler: NetworkHandler!
    var disposeBag:  DisposeBag!
    
    override func setUp() {
        disposeBag = DisposeBag()
        //subject = TipsListNetworking(networkHandler: <#T##NetworkHandler#>)
    }
}
