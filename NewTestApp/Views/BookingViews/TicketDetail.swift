//
//  TicketDetail.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 23.12.2023.
//

import Foundation
import UIKit
import SnapKit

class TicketDetail: UIView {
    //MARK: -Variables-
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    private let titles = [
        "Вылет из", "Страна, город", "Даты", "Кол-во ночей", "Отель", "Номер", "Питание"
    ]
    
    /// Assuming we have a data model that corresponds to the titles
    var bookData: BookData? {
        didSet {
            updateDataViews()
        }
    }
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions -
    private func setupStackView() {
        for title in titles {
            let titleLabel = UILabel()
            titleLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
            titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            titleLabel.text = title
            
            let dataLabel = UILabel()
            dataLabel.textColor = .black
            dataLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            dataLabel.text = "Loading..." //
            
            let rowStackView = UIStackView(arrangedSubviews: [titleLabel, dataLabel])
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.alignment = .center
            rowStackView.spacing = 8

            stackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func updateDataViews() {
        // Assuming bookData has properties corresponding to titles
        guard let dataLabels = stackView.arrangedSubviews as? [UIStackView], let bookData = bookData else { return }
        let data = [
            bookData.departure,
            bookData.arrival_country,
            "\(bookData.tour_date_start) - \(bookData.tour_date_stop)",
            "\(bookData.number_of_nights) ночей",
            bookData.hotel_name,
            bookData.room,
            bookData.nutrition
        ]
        
        for (index, dataLabel) in dataLabels.enumerated() {
            guard let dataView = dataLabel.arrangedSubviews.last as? UILabel else { continue }
            dataView.text = data[index]
        }
    }
}
    
    //MARK: -SetUpViews-
extension TicketDetail {
    private func setUpViews() {
        backgroundColor = .white
        addSubview(stackView)
        setUpConstaints()
    }
    
    private func setUpConstaints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
