//
//  TotalPriceView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class TotalPriceView: UIView {
    //MARK: -Variables-
    private let titles = ["Тур", "Топливный сбор", "Сервисный сбор", "К оплате"]
    
    private var priceLabels = [UILabel]()
        
    var priceDetails: BookData? {
        didSet {
            updateDataViews()
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setupStackView()
        updateDataViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions-
    private func setupStackView() {
        for title in titles {
            let titleLabel = UILabel()
            titleLabel.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
            titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            titleLabel.text = title
            
            let dataLabel = UILabel()
            dataLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            dataLabel.textAlignment = .right
            
            let rowStackView = UIStackView(arrangedSubviews: [titleLabel, dataLabel])
            rowStackView.axis = .horizontal
            rowStackView.distribution = .equalSpacing
            rowStackView.alignment = .center
            
            stackView.addArrangedSubview(rowStackView)
            priceLabels.append(dataLabel) // Keep a reference to the label for later
        }
    }
    
    private func updateDataViews() {
        guard let details = priceDetails else { return }
            
        // Assuming 'BookData' has properties that correspond to the titles
        let data = [
            "\(details.tour_price) ₽", // Tour
            "\(details.fuel_charge) ₽", // Fuel charge
            "\(details.service_charge) ₽", // Service charge
            "\(details.tour_price + details.fuel_charge + details.service_charge) ₽" // Total
        ]
            
            // Update labels with data
        for (index, dataLabel) in priceLabels.enumerated() {
            dataLabel.text = data[index]
            dataLabel.textColor = (index == titles.count - 1) ? .blue : .black
        }
    }
}

    //MARK: -extensions-
extension TotalPriceView {
    private func setUpViews() {
        backgroundColor = .white
        layer.cornerRadius = 15
        addSubview(stackView)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
