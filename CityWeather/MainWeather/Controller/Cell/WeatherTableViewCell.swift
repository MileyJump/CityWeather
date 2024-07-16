//
//  WeatherTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/10/24.
//

import UIKit

final class WeatherTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let bgView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let headerView = HeaderView()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let inset: CGFloat = 15
        let numberOfItemsPerRow: CGFloat = 6 // 한 줄에 보여질 아이템 개수
        let totalSpacing = (2 * inset) + ((numberOfItemsPerRow) * spacing)
        
        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        let height = UIScreen.main.bounds.height
        
        layout.itemSize = CGSize(width: width, height: width * 2.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    // MARK: - init

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Properties
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        bgView.addSubview(collectionView)
        bgView.addSubview(headerView)
     
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
        }
        
        headerView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(bgView).inset(5)
            make.height.equalTo(10)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(bgView).inset(10)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .clear
        backgroundColor = .clear
    }
}


