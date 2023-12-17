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
        return scr
    }()
    private let contentView: HotelContentView = {
        // Set up scrollView and contentView
        let view = HotelContentView()
        return view
    }()
    
   
    
    var hotel: Hotel?
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetchHotelData()
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
}
//MARK: -Extension-
extension HotelViewController {
    private func setUpView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemGray
        view.addSubview(scrollViewH)
        scrollViewH.addSubview(contentView)
        
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        scrollViewH.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
                
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.width.equalTo(scrollViewH.snp.width)
            make.height.equalTo(500)
        }
    }
}
