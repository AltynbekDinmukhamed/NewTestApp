//
//  PassengerInfoField.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class PassengerInfoField: UIView {
    //MARK: -Variables-
    let orderTourist: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.text = "Count турист"
        return lbl
    }()
    
    lazy var hideButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 6
        btn.backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 0.1)
        btn.setImage(UIImage(named: "hideBtn"), for: .normal)
        btn.addTarget(self, action: #selector(hideBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    let nameTxtField: CustomTextField = {
        let txt = CustomTextField()
        txt.titleLabel.text = "Имя"
        txt.placeholder = "Иван"
        txt.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        txt.layer.cornerRadius = 10
        txt.textColor = UIColor(red: 0.079, green: 0.077, blue: 0.167, alpha: 1)
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        return txt
    }()
    
    let surnameTxtField: CustomTextField = {
        let txt = CustomTextField()
        txt.titleLabel.text = "Имя"
        txt.placeholder = "Иван"
        txt.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        txt.layer.cornerRadius = 10
        txt.textColor = UIColor(red: 0.079, green: 0.077, blue: 0.167, alpha: 1)
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        return txt
    }()
    
    let dateOfBirthTextField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.layer.cornerRadius = 10
        txt.placeholder = "Дата рождения"
        return txt
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        return picker
    }()
    
    let citizenTxtField: SecoundCustomTextField = {
        let txt = SecoundCustomTextField()
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.placeholder = "Гражданство"
        return txt
    }()
    
    let passportNumberTxt: SecoundCustomTextField = {
        let txt = SecoundCustomTextField()
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.placeholder = "Номер загранпаспорта"
        return txt
    }()
    
    let timeOfPassportTxt: SecoundCustomTextField = {
        let txt = SecoundCustomTextField()
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.placeholder = "Срок действия загранпаспорта"
        return txt
    }()
    
    private var isExpanded: Bool = true {
        didSet {
            updateView()
        }
    }
    
    private var heightConstraint: Constraint?
    
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDateOfBirthTextField()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Functions-
    
    private func setupDateOfBirthTextField() {
        // Assign datePicker to the textField
        dateOfBirthTextField.inputView = datePicker
            
        // Create a toolbar with a Done button to dismiss the datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
            
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
        toolbar.setItems([flexSpace, doneButton], animated: true)
            
        dateOfBirthTextField.inputAccessoryView = toolbar
        
        // Set the date format displayed in the textField
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    func collapse() {
        isExpanded = false
    }
}

    //MARK: -Extensions-
extension PassengerInfoField {
    private func setUpViews() {
        addSubview(orderTourist)
        addSubview(hideButton)
        addSubview(nameTxtField)
        addSubview(surnameTxtField)
        addSubview(dateOfBirthTextField)
        addSubview(citizenTxtField)
        addSubview(passportNumberTxt)
        addSubview(timeOfPassportTxt)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.snp.makeConstraints { make in
            self.heightConstraint = make.height.equalTo(430).constraint // Use the initial height
        }
        orderTourist.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        hideButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(32)
        }
        
        nameTxtField.snp.makeConstraints { make in
            make.top.equalTo(orderTourist.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        surnameTxtField.snp.makeConstraints { make in
            make.top.equalTo(nameTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        dateOfBirthTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(52)
        }
        citizenTxtField.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        passportNumberTxt.snp.makeConstraints { make in
            make.top.equalTo(citizenTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        timeOfPassportTxt.snp.makeConstraints { make in
            make.top.equalTo(passportNumberTxt.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }
}

//MARK: -Extensions-
extension PassengerInfoField {
    @objc func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func doneAction() {
        dateChanged() // Ensure the date is updated when Done is tapped
        endEditing(true)
    }
}
//MARK: -Exntesions-
extension PassengerInfoField {
    // Method to update view
    private func updateView() {
        // Hide or show text fields based on `isExpanded`
        nameTxtField.isHidden = !isExpanded
        surnameTxtField.isHidden = !isExpanded
        dateOfBirthTextField.isHidden = !isExpanded
        citizenTxtField.isHidden = !isExpanded
        passportNumberTxt.isHidden = !isExpanded
        timeOfPassportTxt.isHidden = !isExpanded
        
        // Update constraints
        if isExpanded {
            // Here, set the constraints for when the view is expanded
            self.heightConstraint?.update(offset: 430)
            setupExpandedConstraints()
        } else {
            self.heightConstraint?.update(offset: 58) // Or your collapsed height
            // When collapsed, we only need to update the bottom constraint to be close to the `orderTourist`
//            nameTxtField.snp.remakeConstraints { make in
//                make.height.equalTo(0) // Set height to 0 to collapse
//            }
            // Make sure to set height constraints of all other fields to 0 using the same pattern
            
            // Update bottom constraint to move up close to the `orderTourist`
//            orderTourist.snp.remakeConstraints { make in
//                make.bottom.equalToSuperview().offset(-16) // Adjust as needed
//            }
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded() // Animate the superview to update layout
            }
        }
        
        // Animate the layout change
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    // Call this when the hide button is tapped
    @objc private func hideBtnTapped(_ sender: UIButton) {
        isExpanded.toggle() // Toggle the expanded state
        let imageName = isExpanded ? "hideBtn" : "showBtn"
        hideButton.setImage(UIImage(named: imageName), for: .normal)
        updateView()
    }
}

extension PassengerInfoField {
    private func setupExpandedConstraints() {
        // Set up constraints for all subviews when the view is expanded
        // Similar to what you have in `setUpConstraints`
    }
}

extension PassengerInfoField {
    func isDataValid() -> Bool {
        // Проверка всех текстовых полей
        // Пример проверки одного поля
        if let name = nameTxtField.text, name.isEmpty {
            nameTxtField.backgroundColor = UIColor.red.withAlphaComponent(0.15)
            return false
        }

        // Проверка других полей
        // ...

        // Если все в порядке, вернуть true
        return true
    }
}

