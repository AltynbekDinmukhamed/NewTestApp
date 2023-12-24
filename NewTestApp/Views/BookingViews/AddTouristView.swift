//
//  AddTourist.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class AddTouristView: UIView {
    //MARK: -Life Cycle-
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.text = "Добавить туриста"
        return lbl
    }()
    
    let plusBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1)
        btn.layer.cornerRadius = 6
        btn.setImage(UIImage(named: "plusBtn"), for: .normal)
        return btn
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

    //MARK: -Exntesions-
extension AddTouristView {
    private func setUpViews() {
        backgroundColor = .white
        layer.cornerRadius = 15
        addSubview(titleLbl)
        addSubview(plusBtn)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        plusBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-13)
            make.height.width.equalTo(24)
        }
    }
}
