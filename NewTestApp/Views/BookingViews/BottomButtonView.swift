//
//  BottomButtonView.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class BottomButtonView: UIView {
    //MARK: -Variables-
    lazy var payBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Оплатить 0 ₽", for: .normal)
        btn.layer.cornerRadius = 15
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        btn.addTarget(self, action: #selector(payTapped), for: .touchUpInside)
        return btn
    }()
    
    var openVc: (() -> Void)?
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions-
}

    //MARK: -Extension-
extension BottomButtonView {
    private func setUpView() {
        backgroundColor = .white
        addSubview(payBtn)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        payBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-28)
        }
    }
}

extension BottomButtonView {
    @objc private func payTapped(_ sender: UIButton) {
        openVc?()
    }
}
