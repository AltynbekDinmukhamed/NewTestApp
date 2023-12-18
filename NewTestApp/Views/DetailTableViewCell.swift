//
//  DetailTableViewCell.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 18.12.2023.
//

import Foundation
import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    //MARK: -Variables-
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title"
        lbl.textColor = UIColor(red: 0.174, green: 0.189, blue: 0.209, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return lbl
    }()
    
    let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Самое необходимое"
        lbl.textColor = UIColor(red: 0.511, green: 0.528, blue: 0.588, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        return lbl
    }()
    
    let arrowImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "Icons")
        img.clipsToBounds = true
        return img
    }()
    
    //MARK: -LifeCycle-
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions-
}

    //MARK: -Extnesions-
extension DetailTableViewCell {
    private func setUpViews() {
        backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
        addSubview(iconImageView)
        addSubview(titleLbl)
        addSubview(subTitleLbl)
        addSubview(arrowImg)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(24)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
        }
        
        subTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
        }
        
        arrowImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}
