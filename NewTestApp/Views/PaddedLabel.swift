//
//  PaddedLabel.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 17.12.2023.
//

import Foundation
import UIKit

class PaddedLabel: UILabel {
    let topInset: CGFloat = 5.0
    let bottomInset: CGFloat = 5.0
    let leftInset: CGFloat = 10.0
    let rightInset: CGFloat = 10.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override func sizeToFit() {
        super.sizeToFit()
        self.frame.size = intrinsicContentSize
    }
}
