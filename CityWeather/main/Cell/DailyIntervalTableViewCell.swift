//
//  DailyIntervalTableViewCell.swift
//  CityWeather
//
//  Created by 최민경 on 7/12/24.
//

import UIKit

final class DailyIntervalTableViewCell: BaseTableViewCell {
    
    let bgView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let headerView = HeaderView()
    let dailyTableView = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(bgView)
        contentView.addSubview(headerView)
        contentView.addSubview(dailyTableView)
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
        }
        
        headerView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(bgView).inset(10)
            make.height.equalTo(20)
        }
        
        dailyTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.bottom.horizontalEdges.equalTo(bgView).inset(10)
        }
    }
    
    override func configureView() {
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        dailyTableView.register(DailyforecastTableViewCell.self, forCellReuseIdentifier: DailyforecastTableViewCell.identifier)
        
        dailyTableView.rowHeight = UITableView.automaticDimension
        dailyTableView.estimatedRowHeight = 100
    }
}

extension DailyIntervalTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyforecastTableViewCell.identifier, for: indexPath) as! DailyforecastTableViewCell
        
        return cell
    }
    
    
}