//
//  TipsListViewModelTests.swift
//  HealthTipsTests
//
//  Created by Arshad Khan on 4/18/21.
//
import RxSwift
import XCTest
@testable import HealthTips

class TipsListViewModelTests: XCTestCase {
    var subject: TipsListViewModel!
    var mockTipsListNetworking: MockTipsListNetworking!
    var disposeBag:  DisposeBag!
    
    override func setUp() {
        mockTipsListNetworking = MockTipsListNetworking()
        disposeBag = DisposeBag()
        subject = TipsListViewModel(tipsListNetworking: mockTipsListNetworking)
    }
    
    func testGetTipsListResponse() {
        let expectation = XCTestExpectation()
        let tips = [Tip(tipId: "1", imageURL: "imageUrl", title: "title", category: "category")]
        mockTipsListNetworking.getHealthTipsAPIResponseObservable = .just(HealthTipsAPIModel(tips: tips))
        
        subject.getTipsListResponse()
            .subscribe(onNext: { tipsListCells  in
                XCTAssertTrue((tipsListCells as Any) is [TipsListCellModel])
                XCTAssertEqual(tipsListCells.count, 1)
                XCTAssertEqual(tipsListCells[0].title, "title")
                XCTAssertEqual(tipsListCells[0].imageUrl, "imageUrl")
                XCTAssertEqual(tipsListCells[0].category, "category")
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
    }
    
    override func tearDown() {
        subject = nil
        mockTipsListNetworking = nil
        disposeBag = nil
    }
}

class MockTipsListNetworking: TipsListNetworkingProtocol {
    var getHealthTipsAPIResponseObservable: Observable<HealthTipsAPIModel> = Observable.empty()
    func getHealthTipsAPIResponse() -> Observable<HealthTipsAPIModel> {
        getHealthTipsAPIResponseObservable
    }
}
