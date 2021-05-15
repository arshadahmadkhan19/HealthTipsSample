//
//  TipsViewCell.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/5/21.
//

import UIKit
import RxSwift

class TipsViewCell: UICollectionViewCell {
    let disposeBag = DisposeBag()

    let tipsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "The stressors of stress on your body and behavior"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(categoryLabel)
        addSubview(tipsImageView)
        addSubview(titleLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(model: TipsListCellModel) {
        categoryLabel.text = model.category
        titleLabel.text = model.title
        
        let imageLoading = ImageLoader()
        
        imageLoading.loadImage(from: model.imageUrl) { image in
            DispatchQueue.main.async {
                self.tipsImageView.image = image
            }
        }
    }
    
    private func setupConstraints() {
        tipsImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tipsImageView.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -10).isActive = true
        tipsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tipsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        categoryLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -2).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
}


class TipsViewHeader: UICollectionReusableView {
    var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today's Tips"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        backgroundColor = .yellow
        headerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
