//
//  InfoAboutCustomer.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 24.12.2023.
//

import Foundation
import UIKit
import SnapKit

class InfoAboutCustomer: UIView {
    //MARK: -Variables-
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        lbl.text = "Информация о покупателе"
        return lbl
    }()
    
    let nameTxtField: UITextField = {
        let txt = CustomTextField()
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.layer.cornerRadius = 10
        txt.textColor = UIColor(red: 0.079, green: 0.077, blue: 0.167, alpha: 1)
        txt.placeholder = "+7 (___) ___-__-__"
        txt.keyboardType = .numberPad
        return txt
    }()
    
    let emailTxtField: UITextField = {
        let txt = CustomTextField()
        txt.titleLabel.text = "email"
        txt.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
        txt.layer.cornerRadius = 10
        txt.textColor = UIColor(red: 0.079, green: 0.077, blue: 0.167, alpha: 1)
        txt.placeholder = "examplemail.000@mail.ru"
        txt.keyboardType = .emailAddress
        return txt
    }()
    
    let termAndConditionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        lbl.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        lbl.numberOfLines = 0
        lbl.text = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
        return lbl
    }()
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        nameTxtField.delegate = self
        emailTxtField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Functions-
    func applyMask(to originalText: String, with mask: String) -> String {
        // Remove any character that is not a number
        let numbers = originalText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // This will hold the final text with mask applied
        var finalText = ""
        
        // These indices will keep track of where we are in both the mask and the input numbers
        var maskIndex = mask.startIndex
        var numberIndex = numbers.startIndex
        
        // Iterate over the mask characters
        while maskIndex < mask.endIndex {
            // If we've run out of numbers to input, break the loop
            if numberIndex >= numbers.endIndex {
                break
            }
            
            // Get the current character from the mask
            let maskChar = mask[maskIndex]
                
            // Check what kind of character we have in the mask
            if maskChar == "7" && numberIndex == numbers.startIndex {
                // If the mask expects a 7 and we're at the start of the input numbers, add the 7
                finalText.append("7")
                numberIndex = numbers.index(after: numberIndex) // Move to the next number
            } else if maskChar == "_" {
                // If the mask has a placeholder, replace it with the current number
                finalText.append(numbers[numberIndex])
                numberIndex = numbers.index(after: numberIndex) // Move to the next number
            } else {
                // If the current character in the mask is not a placeholder, just add it to the final text
                finalText.append(maskChar)
            }
            
            // Move to the next character in the mask
            maskIndex = mask.index(after: maskIndex)
        }
        
        // Add any remaining mask characters
        while maskIndex < mask.endIndex {
            finalText.append(mask[maskIndex])
            maskIndex = mask.index(after: maskIndex)
        }
        
        // Return the final text with the mask applied
        return finalText
    }
    
    func setupHideKeyboardOnTap(viewController: UIViewController) {
        let tap = UITapGestureRecognizer(target: viewController, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

    //MARK: -setupViews()-
extension InfoAboutCustomer {
    private func setUpViews() {
        backgroundColor = .white
        addSubview(titleLbl)
        addSubview(nameTxtField)
        addSubview(emailTxtField)
        addSubview(termAndConditionLbl)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        nameTxtField.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        emailTxtField.snp.makeConstraints { make in
            make.top.equalTo(nameTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        termAndConditionLbl.snp.makeConstraints { make in
            make.top.equalTo(emailTxtField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension InfoAboutCustomer: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTxtField {
            // Логика для поля ввода номера телефона
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            textField.text = applyMask(to: updatedText, with: "+7 (___) ___-__-__")
            return false
        } else if textField == emailTxtField {
            // Для emailTxtField просто разрешаем системе обрабатывать изменения
            return true
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTxtField {
            if isValidEmail(emailTxtField.text) {
                // Email валиден, сброс цвета фона
                emailTxtField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.976, alpha: 1)
            } else {
                // Email невалиден, установка красного цвета фона
                emailTxtField.backgroundColor = UIColor(red: 0.922, green: 0.337, blue: 0.337, alpha: 0.15)
            }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension InfoAboutCustomer {
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
