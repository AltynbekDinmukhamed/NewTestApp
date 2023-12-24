//
//  BookingViewController.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 23.12.2023.
//

import Foundation
import UIKit
import SnapKit

class BookingViewController: UIViewController {
    //MARK: -Variables-
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let bookingTopView: BookingTopView = {
        let view = BookingTopView()
        return view
    }()
    
    let ticketDetailView: TicketDetail =  { 
        let view = TicketDetail()
        return view
    }()
    
    let infoAboutCustomer: InfoAboutCustomer = {
        let view = InfoAboutCustomer()
        return view
    }()
    
    var bookData: BookData?
    //MARK: -Life Cycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        fetchBookData()
    }
    
    //MARK: -functions-
    private func fetchBookData() {
        NetworkService.shared.fetchBookInfo { [weak self] bookData in
            DispatchQueue.main.async {
                self?.bookData = bookData
                self?.updateBookViews()
            }
        }
    }
    
    private func updateBookViews() {
        guard let bookData = bookData else { return }
        DispatchQueue.main.async {
            self.bookingTopView.ratingView.ratingLbl.text = "\(bookData.horating) \(bookData.rating_name)"
            self.bookingTopView.hotelName.text = "\(bookData.hotel_name)"
            self.bookingTopView.addressLabel.text = "\(bookData.hotel_adress)"
            self.ticketDetailView.bookData = bookData
        }
    }
}

    //MARK: -setUpViews Extension-
extension BookingViewController {
    private func setUpViews() {
        title = "Бронирование"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookingTopView)
        contentView.addSubview(ticketDetailView)
        contentView.addSubview(infoAboutCustomer)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        bookingTopView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(120)
        }
        
        ticketDetailView.snp.makeConstraints { make in
            make.top.equalTo(bookingTopView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(280)
        }
        
        infoAboutCustomer.snp.makeConstraints { make in
            make.top.equalTo(ticketDetailView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(232)
        }
    }
}
