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
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .systemGray
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
        view.layer.cornerRadius = 15
        return view
    }()
    
    let infoAboutCustomer: InfoAboutCustomer = {
        let view = InfoAboutCustomer()
        view.layer.cornerRadius = 15
        return view
    }()
    
    let passengerInfoField: PassengerInfoField = {
        let lbl = PassengerInfoField()
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 15
        return lbl
    }()
    
    let secondPassengerInfoField: PassengerInfoField = {
        let field = PassengerInfoField()
        field.backgroundColor = .white
        field.layer.cornerRadius = 15
        field.collapse()
        return field
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
        contentView.addSubview(passengerInfoField)
        contentView.addSubview(secondPassengerInfoField)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        bookingTopView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(135)
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
        
        passengerInfoField.snp.makeConstraints { make in
            make.top.equalTo(infoAboutCustomer.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        secondPassengerInfoField.snp.makeConstraints { make in
            make.top.equalTo(passengerInfoField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
                // Here, do not set a fixed height for the collapsed state
            make.bottom.equalTo(contentView).offset(-8) // Make sure this is the last element
        }
    }
}
