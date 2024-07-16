//
//  ConditionsTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/13/24.
//

import UIKit

final class ConditionsTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    let viewModel = ConditionViewModel()
    
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
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind()
    }
    
    // MARK: - Method
    
    private func bind() {
        viewModel.outputWeatherData.bind { weather in
            self.collectionView.reloadData()
            
        }
    }
    
    // MARK: - UI 구성
    
    override func configureHierarchy() {
        contentView.addSubview(collectionView)
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
        collectionView.backgroundColor = .clear
        backgroundColor = .clear
    }
}

// MARK: - CollectionView Delegate, DataSource

extension ConditionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCase = collectionHeaderType.allCases[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConditionsCollectionViewCell.identifier, for: indexPath) as? ConditionsCollectionViewCell else { fatalError("ConditionsCollectionViewCell 실패 ")}
        cell.headerView.titleLabel.text = cellCase.sectionTitle
        cell.headerView.iconImageViwe.image = UIImage(systemName: cellCase.sectionImage)
        
        guard let value = viewModel.outputWeatherData.value?[0] else { return cell }
        switch indexPath.item {
        case 0:
            cell.configureCell(information: "\(value.wind.speed)m/s", pressure: "", value: "강풍:\(value.wind.gust)m/s")
        case 1:
            cell.configureCell(information: "\(value.clouds.all)%", pressure: "", value: "")
        case 2:
//            cell.configureCell(information: "\(value.main.pressure)", pressure: "hpa", value: "")
            let formattedPressure = formatNumberWithComma(value.main.pressure)
               cell.configureCell(information: formattedPressure, pressure: "hpa", value: "")
        case 3:
            cell.configureCell(information: "\(value.main.humidity)%", pressure: "", value: "")
        default:
            print("ConditionsTableViewCell -", #function)
        }
        return cell
    }
    
    // 세자리마다 쉼표
    func formatNumberWithComma(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}
