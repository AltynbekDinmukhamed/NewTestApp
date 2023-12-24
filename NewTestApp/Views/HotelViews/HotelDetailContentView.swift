//
//  HotelDetailContentView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 17.12.2023.
//

import Foundation
import UIKit
import SnapKit

class HotelDetailContentView: UIView {
    //MARK: -Variable-
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.text = "Об отеле"
        return lbl
    }()
    
    let peculiaritiesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let descriptionTextLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!"
        return lbl
    }()
    
    let detailTable: UITableView = {
        let table = UITableView()
        table.register(DetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
        table.layer.cornerRadius = 15
        return table
    }()
    
    let imgNames = ["close-square", "emoji-happy", "tick-square"]
    let titleNames = ["Удобства", "Что включено", "Что не включено"]
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        detailTable.delegate = self
        detailTable.dataSource = self
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Functions-
    func setupPeculiarities(labels: [String]) {
        var currentHorStackView = createHorizontalStackView()
        peculiaritiesStackView.addArrangedSubview(currentHorStackView)
        for label in labels {
            let lbl = PaddedLabel()
            lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
            lbl.font = UIFont(name: "SFProDisplay-Medium", size: 16)
            lbl.text = label
            lbl.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
            lbl.layer.cornerRadius = 5
            lbl.layer.masksToBounds = true
            lbl.textAlignment = .center
            // Assume the label is not too wide to fit on the current line.
            var labelFitsInCurrentLine = true
            // Calculate the label width
            let labelWidth = lbl.intrinsicContentSize.width
            // Calculate the current line width
            let currentLineWidth = currentHorStackView.arrangedSubviews.reduce(0) { result, subview in
                result + (subview.intrinsicContentSize.width + currentHorStackView.spacing)
            }
            // Check if adding this label would exceed the available width
            if currentLineWidth + labelWidth + currentHorStackView.spacing > peculiaritiesStackView.bounds.width {
                // The label doesn't fit in the current line, create a new line
                labelFitsInCurrentLine = false
                currentHorStackView = createHorizontalStackView()
                peculiaritiesStackView.addArrangedSubview(currentHorStackView)
            }
            
            if labelFitsInCurrentLine {
                currentHorStackView.addArrangedSubview(lbl)
            } else {
                // Add the label to the new line
                currentHorStackView.addArrangedSubview(lbl)
            }
        }
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let horStackView = UIStackView()
        horStackView.axis = .horizontal
        horStackView.distribution = .fillProportionally
        horStackView.spacing = 5
        horStackView.alignment = .center
        return horStackView
    }
}

    //MARK: -Set Up Views extensions-
extension HotelDetailContentView {
    private func setUpViews() {
        layer.cornerRadius = 5
        backgroundColor = .white
        addSubview(titleLbl)
        addSubview(peculiaritiesStackView)
        addSubview(descriptionTextLbl)
        addSubview(detailTable)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        peculiaritiesStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        descriptionTextLbl.snp.makeConstraints { make in
            make.top.equalTo(peculiaritiesStackView.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        detailTable.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextLbl.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
    //MARK: -Extensions TableView Delegate
extension HotelDetailContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 3
    }
}
//MARK: -Extenstion TableView DataSource-
extension HotelDetailContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        cell.iconImageView.image = UIImage(named: imgNames[indexPath.row % imgNames.count] )
        cell.titleLbl.text = titleNames[indexPath.row % titleNames.count]
        return cell
    }
    
    
}
