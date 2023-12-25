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
    
    let addTouristView: AddTouristView = {
        let view = AddTouristView()
        return view
    }()
    
    let totalPrice: TotalPriceView = {
        let view = TotalPriceView()
        return view
    }()
    
    let payBottomView: BottomButtonView = {
        let view = BottomButtonView()
        return view
    }()
    
    var bookData: BookData?
    //MARK: -Life Cycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        fetchBookData()
//        payBottomView.openVc = { [weak self] in
//            self?.openVc()
//        }
        infoAboutCustomer.setupHideKeyboardOnTap(viewController: self)
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
            self.totalPrice.priceDetails = bookData
        }
    }
    
    private func openVc() {
        navigationController?.pushViewController(CongratulationViewController(), animated: true)
    }
}

    //MARK: -setUpViews Extension-
extension BookingViewController {
    private func setUpViews() {
        title = "Бронирование"
        view.backgroundColor = .white
        payBottomView.openVc = { [weak self] in
            self?.checkDataAndProceedToPayment()
        }
        view.addSubview(scrollView)
        view.addSubview(payBottomView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookingTopView)
        contentView.addSubview(ticketDetailView)
        contentView.addSubview(infoAboutCustomer)
        contentView.addSubview(passengerInfoField)
        contentView.addSubview(secondPassengerInfoField)
        contentView.addSubview(addTouristView)
        contentView.addSubview(totalPrice)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        payBottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(88)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(payBottomView.snp.top)
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
        }
        
        addTouristView.snp.makeConstraints { make in
            make.top.equalTo(secondPassengerInfoField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        totalPrice.snp.makeConstraints { make in
            make.top.equalTo(addTouristView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView).offset(-8)
        }
    }
}

extension BookingViewController {
    private func checkDataAndProceedToPayment() {
        var isDataValid = true

        // Проверка данных в infoAboutCustomer
        if !infoAboutCustomer.isDataValid() {
            isDataValid = false
        }
        // Проверка данных в passengerInfoField
        if !passengerInfoField.isDataValid() {
            isDataValid = false
        }
        // Проверка данных в secondPassengerInfoField
        if !secondPassengerInfoField.isDataValid() {
            isDataValid = false
        }
        // Если данные валидны, переходим к экрану оплаты
        if isDataValid {
            openVc()
        } else {
            // Показываем ошибку
            showErrorAlert()
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не все поля заполнены корректно", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
