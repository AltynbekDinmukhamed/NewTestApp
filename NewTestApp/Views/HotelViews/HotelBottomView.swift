//
//  HotelBottomView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 18.12.2023.
//

import Foundation
import UIKit
import SnapKit

class HotelBottomView: UIView {
    //MARK: -Variabels-
    lazy var chooseNumberBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("К выбору номера", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(chooseBtnTapped), for: .touchUpInside)
        return btn
    }()
    ///MARK: closure that defined to open a new Controller
    var onChooseNumberButtonTapped: (() -> Void)?
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -functions-
}

    //MARK: -SetupViews-
extension HotelBottomView {
    private func setUpViews() {
        backgroundColor = .white
        layer.cornerRadius = 5
        addSubview(chooseNumberBtn)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        chooseNumberBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-28)
        }
    }
}

extension HotelBottomView {
    @objc private func chooseBtnTapped(_ sender: UIButton) {
        onChooseNumberButtonTapped?()
    }
}
