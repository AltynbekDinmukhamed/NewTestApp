//
//  ViewController.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 16.12.2023.
//

import UIKit
import SnapKit

class HotelViewController: UIViewController {
    //MARK: -Variables-
    private let scrollViewH: UIScrollView = {
        let scr = UIScrollView()
        scr.isScrollEnabled = true
        scr.showsVerticalScrollIndicator = false
        return scr
    }()
    private let contentView: HotelContentView = {
        let view = HotelContentView()
        return view
    }()
    
    private let hotelDetailView: HotelDetailContentView = {
        let view = HotelDetailContentView()
        return view
    }()
    
    private let hoteBottom: HotelBottomView = {
        let view = HotelBottomView()
        return view
    }()
    
    var hotel: Hotel?
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetchHotelData()
        
        hoteBottom.onChooseNumberButtonTapped = {[weak self] in
            self?.openNumberViewControllee()
        }
    }
    //MARK: -Fucntions-
    
    //MARK: -Network fetching
    private func fetchHotelData() {
        NetworkService.shared.fetchHotelData { [weak self] hotel in
            DispatchQueue.main.async {
                self?.hotel = hotel
                self?.updateViews()
            }
        }
    }
    
    private func updateViews() {
        guard let hotelData = hotel else { return }
        
        downloadImages(from: hotelData.image_urls) { [weak self] images in
            DispatchQueue.main.async {
                self?.contentView.imageCarouselView.images = images
            }
        }
        
        DispatchQueue.main.async {
            self.contentView.ratingView.ratingLbl.text = "\(hotelData.rating), \(hotelData.rating_name)"
            self.contentView.hotelName.text = hotelData.name
            self.contentView.addressLabel.text = hotelData.adress
            self.contentView.priceLabel.text = "от \(hotelData.minimal_price) ₽"
            self.contentView.forTourLabel.text = "\(hotelData.price_for_it)"
            self.hotelDetailView.setupPeculiarities(labels: hotelData.about_the_hotel.peculiarities)
            self.hotelDetailView.descriptionTextLbl.text = hotelData.about_the_hotel.description
        }
    }
    
    private func downloadImages(from urls: [String], completion: @escaping ([UIImage]) -> Void) {
        var images: [UIImage] = []
        let dispatchGroup = DispatchGroup()
        
        urls.forEach { url in
            guard let imageUrl = URL(string: url) else { return }
            
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                defer { dispatchGroup.leave() }
                
                if let data = data, let image = UIImage(data: data) {
                    images.append(image)
                }
            }.resume()
            
            dispatchGroup.notify(queue: .main) {
                completion(images)
            }
        }
    }
    ///MARK: -Functsion that open the new Number View Controller-
    private func openNumberViewControllee() {
        let numberViewController = NumberViewController()
        navigationController?.pushViewController(numberViewController, animated: true)
        
    }
}
//MARK: -Extension-
extension HotelViewController {
    private func setUpView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemGray
        view.addSubview(scrollViewH)
        scrollViewH.addSubview(contentView)
        scrollViewH.addSubview(hotelDetailView)
        scrollViewH.addSubview(hoteBottom)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        scrollViewH.snp.makeConstraints { make in
            make.edges.equalTo(view)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.bottom.equalTo(hoteBottom.snp.top).offset(-12)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(scrollViewH.snp.width)
            make.height.equalTo(500)
        }
        
        hotelDetailView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(scrollViewH.snp.width)
            // Set a height constraint only if you know the content height
            // If the content is dynamic, you might want to remove this
            make.height.equalTo(480)
            // This is the key part: the bottom of the last view should define the scroll view's content size
            make.bottom.equalToSuperview()
        }
        
        hoteBottom.snp.makeConstraints { make in
            make.top.equalTo(hotelDetailView.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(88)
        }
    }
}
