//
//  CustomTextField.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomTextField: UITextField {
    //MARK: -Varibles-
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.661, green: 0.672, blue: 0.717, alpha: 1)
        return label
    }()
    
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}
//MARK: -setUpViews-
extension CustomTextField {
    private func setupViews() {
        addSubview(titleLabel)
            
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.top).offset(24)
            make.leading.equalTo(self).offset(20)
        }
            
        // Update the padding for the placeholder and text
        let paddingView = UIView()
        paddingView.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
            
        leftView = paddingView
        leftViewMode = .always
    }
}
//MARK: - overide functions -
extension CustomTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets())
    }
        
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets())
    }
        
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets())
    }
        
    private func textInsets() -> UIEdgeInsets {
        let titleHeight = titleLabel.frame.size.height
        return UIEdgeInsets(top: titleHeight + 8, left: 20, bottom: 0, right: 20)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure the titleLabel is aligned correctly
        titleLabel.snp.updateConstraints { make in
            make.bottom.equalTo(self.snp.top).offset(24)
        }
    }
}
