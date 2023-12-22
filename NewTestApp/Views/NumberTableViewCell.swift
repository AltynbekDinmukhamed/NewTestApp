//
//  NumberTableViewCell.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 22.12.2023.
//

import Foundation
import UIKit
import SnapKit

class NumberTableViewCell: UITableViewCell {
    //MARK: -Variables-
    let carouselImageView: ImageCarouselView = {
        let view = ImageCarouselView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Text"
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let peculiaritiesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let detailBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Подробнее о номере >", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        btn.setTitleColor(UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 0.1)
        return btn
    }()
    
    let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "000 000"
        lbl.font = UIFont(name: "SFProDisplay-Semibold", size: 30)
        lbl.textColor = .black
        return lbl
    }()
    
    let nightLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "test data"
        lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return lbl
    }()
    
    let chooseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Выбрать номер", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 15
        return btn
    }()
    //MARK: -LifeCycle-
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        carouselImageView.layoutIfNeeded()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let result = carouselImageView.hitTest(convert(point, to: carouselImageView), with: event) {
            return result
        }
        return super.hitTest(point, with: event)
    }
    //MARK: -funtions-
    func configureWithImageURLs(_ urls: [String]) {
        downloadAndSetImages(url: urls)
    }
    
    private func downloadAndSetImages(url: [String]) {
        var images = [UIImage]()
        let group = DispatchGroup()
        
        url.forEach { urlString in
            guard let url = URL(string: urlString) else { return }
            group.enter()
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }
                if let data = data, let image = UIImage(data: data) {
                    images.append(image)
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            self.carouselImageView.images = images
        }
    }
    
    func setupPeculiarities(labels: [String]) {
        var currentHorStackView = createHorizontalStackView()
        peculiaritiesStackView.addArrangedSubview(currentHorStackView)
        for label in labels {
            let lbl = PaddedLabel()
            lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
            lbl.font = UIFont(name: "SFProDisplay-Medium", size: 16)
            lbl.text = label
            lbl.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1)
            lbl.layer.cornerRadius = 5
            lbl.layer.masksToBounds = true
            lbl.textAlignment = .center
            // Assume the label is not too wide to fit on the current line.
            var labelFitsInCurrentLine = true
            // Calculate the label width
            let labelWidth = lbl.intrinsicContentSize.width
            // Calculate the current line width
            let currentLineWidth = currentHorStackView.arrangedSubviews.reduce(0) { result, subview in
                result + (subview.intrinsicContentSize.width + currentHorStackView.spacing)
            }
            // Check if adding this label would exceed the available width
            if currentLineWidth + labelWidth + currentHorStackView.spacing > peculiaritiesStackView.bounds.width {
                // The label doesn't fit in the current line, create a new line
                labelFitsInCurrentLine = false
                currentHorStackView = createHorizontalStackView()
                peculiaritiesStackView.addArrangedSubview(currentHorStackView)
            }
            
            if labelFitsInCurrentLine {
                currentHorStackView.addArrangedSubview(lbl)
            } else {
                // Add the label to the new line
                currentHorStackView.addArrangedSubview(lbl)
            }
        }
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let horStackView = UIStackView()
        horStackView.axis = .horizontal
        horStackView.distribution = .fillProportionally
        horStackView.spacing = 5
        horStackView.alignment = .center
        return horStackView
    }
    
}

    //MARK: -Extensions-
extension NumberTableViewCell {
    private func setUpViews(){
        backgroundColor = .white
        addSubview(carouselImageView)
        addSubview(nameLabel)
        addSubview(peculiaritiesStackView)
        addSubview(detailBtn)
        addSubview(priceLbl)
        addSubview(nightLbl)
        addSubview(chooseBtn)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        carouselImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(257)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(carouselImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        peculiaritiesStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        detailBtn.snp.makeConstraints { make in
            make.top.equalTo(peculiaritiesStackView.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(29)
            make.width.equalTo(192)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.top.equalTo(detailBtn.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        nightLbl.snp.makeConstraints { make in
            make.top.equalTo(detailBtn.snp.bottom).offset(30)
            make.leading.equalTo(priceLbl.snp.trailing).offset(8)
        }
        
        chooseBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
}
