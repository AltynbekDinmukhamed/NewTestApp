//
//  CongratulationViewController.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 25.12.2023.
//

import Foundation
import UIKit
import SnapKit

class CongratulationViewController: UIViewController {
    //MARK: -Varibles-
    let congImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "congImg")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        img.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        return img
    }()
    
    let orderGetLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ваш заказ принят в работу"
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        return lbl
    }()
    
    let confirmOrder: UILabel = {
        let lbl = UILabel()
        lbl.text = "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        lbl.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        return lbl
    }()
    
    let bottomView: BottomButtonView = {
        let view = BottomButtonView()
        view.payBtn.setTitle("Супер!", for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.91, green: 0.914, blue: 0.925, alpha: 1).cgColor
        return view
    }()
    
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        bottomView.popBack = { [weak self] in
            self?.popBack()
        }
    }
    
    //MARK: -Functions-
    private func popBack() {
        navigationController?.popViewController(animated: true)
    }
}

    //MARK: -Extesnions SetUpViews()-
extension CongratulationViewController {
    private func setUpViews() {
        title = "Заказ оплачен"
        view.backgroundColor = .white
        view.addSubview(congImg)
        view.addSubview(orderGetLbl)
        view.addSubview(confirmOrder)
        view.addSubview(bottomView)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        confirmOrder.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
        
        orderGetLbl.snp.makeConstraints { make in
            make.bottom.equalTo(confirmOrder.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        congImg.snp.makeConstraints { make in
            make.bottom.equalTo(orderGetLbl).offset(-32)
            make.centerX.equalToSuperview()
            make.width.equalTo(94)
            make.height.equalTo(94)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(88)
        }
    }
}
