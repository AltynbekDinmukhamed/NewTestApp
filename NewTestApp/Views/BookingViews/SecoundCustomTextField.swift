//
//  SecoundCustomTextField.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class SecoundCustomTextField: UITextField {
    //MARK: -Variabels-
    
    //MARK: -LifeCylce-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure the titleLabel is aligned correctly
    }
    //MARK: -Functions-
    private func setUpViews() {
        layer.cornerRadius = 10
        font = UIFont(name: "SFProDisplay-Regular", size: 17)
    }
}

extension SecoundCustomTextField {
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
        return UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20)
    }
}
