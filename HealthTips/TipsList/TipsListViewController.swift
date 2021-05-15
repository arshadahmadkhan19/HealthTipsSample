//
//  TipsListViewController.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/3/21.
//

import RxSwift
import UIKit

class TipsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let viewModel: TipsListViewModelProtocol
    private var collectionViewData: [TipsListCellModel] = []
    let disposeBag = DisposeBag()
    required init(viewModel: TipsListViewModelProtocol) {
        self.viewModel = viewModel
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = .white
        collectionView?.register(TipsViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TipsViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        onPageLoadUI()
    }
    
    private func onPageLoadUI() {
        viewModel.getTipsListResponse()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { cellModel in
                self.collectionViewData = cellModel
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension TipsListViewController {
    
    // MARK: CollectionView Delegates
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? TipsViewCell
        if collectionViewData.count > 0 {
            cell?.setupViews(model: collectionViewData[indexPath.item])
        }
        cell?.layer.cornerRadius = 20.0
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var supplementaryView = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
        }
        return supplementaryView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0  {
            return CGSize(width: view.frame.width, height: 70)
        }
        return .zero
    }
}
