//
//  ratingView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 17.12.2023.
//

import Foundation
import UIKit
import SnapKit

class RatingView: UIView {
    //MARK: -Variables-
    let starImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "star")
        return image
    }()
    
    let ratingLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "5 Превосходно"
        lbl.textColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 16)
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

//MARK: -Extension setting views-
extension RatingView {
    private func setUpViews() {
        layer.backgroundColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2).cgColor
        layer.cornerRadius = 5
        addSubview(starImage)
        addSubview(ratingLbl)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        starImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(15)
        }
        
        ratingLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(starImage.snp.trailing).offset(2)
        }
    }
}
