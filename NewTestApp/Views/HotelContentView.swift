//
//  HotelContentView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 17.12.2023.
//

import Foundation
import UIKit
import SnapKit

class HotelContentView: UIView {
    //MARK: -Variables-
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        lbl.text = "Отель"
        return lbl
    }()
    let imageCarouselView: ImageCarouselView = {
        let view = ImageCarouselView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 15
        return view
    }()
    
    let ratingView: RatingView = {
        let view = RatingView()
        return view
    }()
    
    let hotelName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hotel Name"
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        lbl.text = "Madinat"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Semibold", size: 30)
        lbl.text = "от 134 673 ₽"
        return lbl
    }()
    
    let forTourLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        lbl.text = "за тур с "
        return lbl
    }()
    
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}

extension HotelContentView {
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        // Add subviews
        addSubview(titleLbl)
        addSubview(imageCarouselView)
        addSubview(ratingView)
        addSubview(hotelName)
        addSubview(addressLabel)
        addSubview(priceLabel)
        addSubview(forTourLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(19)
        }
                        
        imageCarouselView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(257) // Arbitrary height for the carousel
        }
                
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(imageCarouselView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
                
        hotelName.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
                
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelName.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
                
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        forTourLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(30)
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
        }
    }
}

extension HotelContentView {
    @objc private func chooseRoomButtonTapped() {
        
    }
}
