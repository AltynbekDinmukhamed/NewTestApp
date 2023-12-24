//
//  BookingTopView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 23.12.2023.
//

import Foundation
import UIKit
import SnapKit

class BookingTopView: UIView {
    //MARK: -Variables-
    let ratingView: RatingView = {
        let ratingView = RatingView()
        return ratingView
    }()
    
    let hotelName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hotel Name"
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        lbl.text = "Madinat"
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Functions-
}

    //MARK: -Extensions setUpViews-
extension BookingTopView {
    private func setUpViews() {
        backgroundColor = .white
        layer.cornerRadius = 15
        addSubview(ratingView)
        addSubview(hotelName)
        addSubview(addressLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(29)
            make.width.equalTo(149)
        }
        
        hotelName.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelName.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
    }
}
