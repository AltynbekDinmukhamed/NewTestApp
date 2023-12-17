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
            for (index, imageView) in imageViews.enumerated() {
                imageView.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollView.frame.width)
                    make.height.equalToSuperview()
                    
                    if index == 0 {
                        // First imageView
                        make.leading.equalToSuperview()
                    } else {
                        // Subsequent imageViews
                        make.leading.equalTo(imageViews[index - 1].snp.trailing)
                    }
                    
                    if index == imageViews.count - 1 {
                        // Last imageView
                        make.trailing.equalToSuperview()
                    }
                }
            }
            
            pageControl.numberOfPages = images.count
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
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
