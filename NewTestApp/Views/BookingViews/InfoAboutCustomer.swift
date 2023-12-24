//
//  InfoAboutCustomer.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class InfoAboutCustomer: UIView {
    //MARK: -Variables-
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.text = "Информация о покупателе"
        return lbl
    }()
    
    let nameTxtField: UITextField = {
        let txt = CustomTextField()
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.layer.cornerRadius = 10
        txt.textColor = UIColor(red: 0.079, green: 0.077, blue: 0.167, alpha: 1)
        txt.placeholder = "+7 (___) ___-__-__"
        txt.keyboardType = .phonePad
        return txt
    }()
    
    let emailTxtField: UITextField = {
        let txt = CustomTextField()
        txt.titleLabel.text = "email"
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.layer.cornerRadius = 10
        txt.textColor = UIColor(red: 0.079, green: 0.077, blue: 0.167, alpha: 1)
        txt.placeholder = "examplemail.000@mail.ru"
        txt.keyboardType = .emailAddress
        return txt
    }()
    
    let termAndConditionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        lbl.numberOfLines = 0
        lbl.text = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
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

    //MARK: -setupViews()-
extension InfoAboutCustomer {
    private func setUpViews() {
        backgroundColor = .white
        addSubview(titleLbl)
        addSubview(nameTxtField)
        addSubview(emailTxtField)
        addSubview(termAndConditionLbl)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        nameTxtField.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        emailTxtField.snp.makeConstraints { make in
            make.top.equalTo(nameTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        termAndConditionLbl.snp.makeConstraints { make in
            make.top.equalTo(emailTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
