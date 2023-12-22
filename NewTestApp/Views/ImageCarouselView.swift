//
//  imageCarousel.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 16.12.2023.
//

import Foundation
import UIKit
import SnapKit

class ImageCarouselView: UIView, UIScrollViewDelegate {
    //MARK: -Variables-
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var imageViews: [UIImageView] = []
    
    var images: [UIImage] = [] {
        didSet {
            setUpImages()
        }
    }
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpImages()
    }
    //MARK: -Functions-
    private func setUpImages() {
    // Remove all existing imageViews from the scrollView before setting them up again
        imageViews.forEach { $0.removeFromSuperview() }
        imageViews.removeAll()
        
        for img in images {
            let imageView = UIImageView(image: img)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }

        // Set up constraints for imageViews
        var previousImageView: UIImageView?
        for imageView in imageViews {
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(scrollView.frame.width)
                make.height.equalToSuperview()
                    
//                if index == 0 {
//                    // First imageView
//                    make.leading.equalToSuperview()
//                } else {
//                    // Subsequent imageViews
//                    make.leading.equalTo(imageViews[index - 1].snp.trailing)
//                }
                
                if let previousImageView = previousImageView {
                    make.leading.equalTo(previousImageView.snp.trailing)
                } else {
                    make.leading.equalToSuperview()
                }
                
                previousImageView = imageView
                    
//                if index == imageViews.count - 1 {
//                    // Last imageView
//                    make.trailing.equalToSuperview()
//                }
            }
        }
            
        imageViews.last?.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        pageControl.numberOfPages = images.count
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPageControl() {
        pageControl = UIPageControl()
        addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("Touches began")
    }
}

//MARK: -extensions-
extension ImageCarouselView {
    private func setUpViews() {
        backgroundColor = .white
        setUpConstraints()
        setupScrollView()
        setupPageControl()
    }
    
    private func setUpConstraints() {
        
    }
}

extension ImageCarouselView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

//class ImageCarouselView: UIScrollViewDelegate {  // Declare conformance here
//    // ...
//    // Other properties and methods
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pageIndex = round(scrollView.contentOffset.x / frame.width)
//        pageControl.currentPage = Int(pageIndex)
//    }
//
//    // ...
//}

