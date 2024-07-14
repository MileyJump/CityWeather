//
//  ConditionsTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit

class ConditionsTableViewCell: BaseTableViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let inset: CGFloat = 15
        let numberOfItemsPerRow: CGFloat = 5 // 한 줄에 보여질 아이템 개수
        let totalSpacing = (2 * inset) + ((numberOfItemsPerRow) * spacing)
        
        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        let height = UIScreen.main.bounds.height
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    override func configureHierarchy() {
        
        contentView.addSubview(collectionView)
        
        collectionView.backgroundColor = .blue
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
