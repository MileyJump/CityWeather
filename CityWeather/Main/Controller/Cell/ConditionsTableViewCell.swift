//
//  ConditionsTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit

final class ConditionsTableViewCell: BaseTableViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let inset: CGFloat = 5
        let numberOfItemsPerRow: CGFloat = 2 // 한 줄에 보여질 아이템 개수
        let totalSpacing = (2 * inset) + ((numberOfItemsPerRow) * spacing)
        
        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.scrollDirection = .vertical
        
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
    
    override func configureView() {
        collectionView.register(ConditionsCollectionViewCell.self, forCellWithReuseIdentifier: ConditionsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension ConditionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConditionsCollectionViewCell.identifier, for: indexPath) as? ConditionsCollectionViewCell else { fatalError("ConditionsCollectionViewCell 실패 ")}
//        cell.headerView.configureHeader(type: SectionType.conditions(title: "바람속도", imageName: "star"))
        cell.configureCell(collectionHeaderType.allCases[indexPath.row])
//        cell.headerView.configureHeader(type: collectionHeaderType.allCases[indexPath.row])
        return cell
    }
    
    
    
}
