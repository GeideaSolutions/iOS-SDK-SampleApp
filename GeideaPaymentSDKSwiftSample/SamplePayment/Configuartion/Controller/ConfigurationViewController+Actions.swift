//
//  ConfigurationViewController+Actions.swift
//  GeideaPaymentSDKSwiftSample
//
//  Created by Saiempu Stephy on 12/06/23.
//

import UIKit
import GeideaPaymentSDK

extension ConfiguartionViewController {
    
    @objc func labelTapped(sender: UIButton) {
        radioButtonArray.forEach{
            $0.selected = false
        }
        languageArray.forEach{
            $0.isSelected = false
        }
        sender.isSelected = true
        for selectedLabel in languageArray {
            if selectedLabel.isSelected {
                if let indexSelection = languageArray.firstIndex(where: {$0 == selectedLabel})  {
                    radioButtonArray[indexSelection].selected = true
                    if selectedLabel.titleLabel?.text == "English" {
                        GeideaPaymentAPI.setlanguage(language: Language.english)
                        UserDefaults.standard.set(Language.english.rawValue, forKey: "language")
                    } else if selectedLabel.titleLabel?.text == "Arabic" {
                        GeideaPaymentAPI.setlanguage(language: Language.arabic)
                        UserDefaults.standard.set(Language.arabic.rawValue, forKey: "language")
                    }
                }
            }
        }
    }
    
    @objc func buttonOneTapped(sender: UITapGestureRecognizer){
        
        radioButtonArray.forEach{
            $0.selected = false
        }
        (sender.view as? RadioButton)?.selected = true
        
        for (index, button) in radioButtonArray.enumerated() {
            if button.selected {
                let selectedLabel = languageArray[index]
                if selectedLabel.titleLabel?.text == "English" {
                    GeideaPaymentAPI.setlanguage(language: Language.english)
                    UserDefaults.standard.set(Language.english.rawValue, forKey: "language")
                } else if selectedLabel.titleLabel?.text == "Arabic" {
                    GeideaPaymentAPI.setlanguage(language: Language.arabic)
                    UserDefaults.standard.set(Language.arabic.rawValue, forKey: "language")
                }
            }
        }
    }
    
    @objc func paymentlabelTapped(sender: UIButton){
        sender.isSelected = !sender.isSelected
        for selectedLabel in paymentOptionsArray {
            if selectedLabel.titleLabel?.text ==  sender.titleLabel?.text {
                if let indexSelection = paymentOptionsArray.firstIndex(where: {$0 == selectedLabel})  {
                    checkBoxArray[indexSelection].selected =  sender.isSelected
                    if selectedLabel.titleLabel?.text == "Show Receipt" {
                        viewModel.showReceipt = sender.isSelected
                    } else if selectedLabel.titleLabel?.text == "Show Email" {
                        viewModel.showEmail = sender.isSelected
                    } else if selectedLabel.titleLabel?.text == "Show Address" {
                        viewModel.showAddress = sender.isSelected
                    }
                }
            }
        }
    }
    
    @objc func checkBoxTapped(sender: UITapGestureRecognizer){
        (sender.view as? CheckBox)?.selected = !((sender.view as? CheckBox)?.selected ?? false)
        
        for (index, button) in checkBoxArray.enumerated() {
            if button == (sender.view as? CheckBox) {
                let selectedLabel = paymentOptionsArray[index]
                if selectedLabel.titleLabel?.text == "Show Receipt" {
                    viewModel.showReceipt = (sender.view as? CheckBox)?.selected
                } else if selectedLabel.titleLabel?.text == "Show Email" {
                    viewModel.showEmail = (sender.view as? CheckBox)?.selected
                } else if selectedLabel.titleLabel?.text == "Show Address" {
                    viewModel.showAddress = (sender.view as? CheckBox)?.selected
                }
            }
        }
    }
    
    @objc func billingButtonTapped(sender: UIButton) {
        billingCheckbox.selected = !billingCheckbox.selected
        updateShippingAddressDetails(selected: billingCheckbox.selected)
    }
    
    @objc func billingCheckBoxTapped(sender: UITapGestureRecognizer) {
        (sender.view as? CheckBox)?.selected = !((sender.view as? CheckBox)?.selected ?? false)
        updateShippingAddressDetails(selected: (sender.view as? CheckBox)?.selected ?? false)
    }
    
    func updateShippingAddressDetails(selected: Bool) {
        if selected {
            shippingCountryTextField.text = billingCountryTextField.text
            shippingCityNameTextField.text = billingCityNameTextField.text
            shippingStreetNameTextField.text = billingStreetNameTextField.text
            shippingPostCodeTextField.text = billingPostCodeTextField.text
        } else {
            shippingCountryTextField.text = "GBR"
            shippingCityNameTextField.text = "London"
            shippingStreetNameTextField.text = "London 1, address"
            shippingPostCodeTextField.text = "12345"
        }
    }
    
    @objc func initiatedBy(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Initiated By", message: "Please Select the initiated by option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Internet", style: .default , handler:{ (UIAlertAction)in
            self.initiatedTextField.text = "Internet"
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveConfigButtonClicked() {
//        if !GeideaPaymentAPI.isCredentialsAvailable() {
            GeideaPaymentAPI.setCredentials(withMerchantKey: viewModel.key ?? "", andPassword: viewModel.password ?? "")
//        }
        viewModel.showReceipt = firstCheckBox.selected
        viewModel.showEmail = secondCheckBox.selected
        viewModel.showAddress = thirdCheckBox.selected
        viewModel.merchantID = merchantReferenceTextField.text
        if initiatedTextField.text?.isEmpty ?? true {
            viewModel.initiatedBy = "Internet"
        } else {
            viewModel.initiatedBy = initiatedTextField.text ?? ""
        }
        
        viewModel.selectedCurrency = currencyTextField.text
        viewModel.callBackUrl = callBackUrlTextField.text
        let shippingAddress = GDAddress(withCountryCode: shippingCountryTextField.text, andCity: shippingCityNameTextField.text, andStreet: shippingStreetNameTextField.text, andPostCode: shippingPostCodeTextField.text)
        let billingAddress = GDAddress(withCountryCode: billingCountryTextField.text, andCity: billingCityNameTextField.text, andStreet: billingStreetNameTextField.text, andPostCode: billingPostCodeTextField.text)
        let customerDetails = GDCustomerDetails(withEmail: customerEmailTextField.text, andCallbackUrl: callBackUrlTextField.text, merchantReferenceId: merchantReferenceTextField.text, shippingAddress: shippingAddress, billingAddress: billingAddress, paymentOperation: .NONE)
        viewModel.customerDetails = customerDetails
        navigationController?.popViewController(animated: true)
        
     let config = Configuration(
            merchantKey: merchantKey.text,
            merchantPassword: passwordKey.text,
            currency: currencyTextField.text,
            merchantID: merchantReferenceTextField.text,
            initiatedBy: initiatedTextField.text,
            callBackUrl: callBackUrlTextField.text,
            customerEmail: customerEmailTextField.text,
            showAddress: thirdCheckBox.selected,
            showEmail: secondCheckBox.selected,
            showReceipt: firstCheckBox.selected,
            shippingCountry: shippingCountryTextField.text,
            shippingCityName: shippingCityNameTextField.text,
            shippingStreetName: shippingStreetNameTextField.text,
            shippingPostCode: shippingPostCodeTextField.text,
            billingCountry: billingCountryTextField.text,
            billingCityName: billingCityNameTextField.text,
            billingStreetName: billingStreetNameTextField.text,
            billingPostCode: billingPostCodeTextField.text,
            environment: environmentTextField.text
        )
        config.saveToUserDefaults()
        let alert = UIAlertController(title: "", message: "Configuration Saved Successfully.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @objc func saveButtonClicked() {
        viewModel.updateCredentials(key: merchantKey.text, password: passwordKey.text)
    }
    
    @objc func clearButtonClicked() {
        merchantKey.text = ""
        passwordKey.text = ""
    }
    
    func changeToProdCredentials() {
        merchantKey.text = ""
        passwordKey.text = ""
        viewModel.updateCredentials(key: merchantKey.text, password: passwordKey.text)
    }
}

struct Configuration: Codable {
    let merchantKey: String?
    let merchantPassword: String?
    let currency: String?
    let merchantID: String?
    let initiatedBy: String?
    let callBackUrl: String?
    let customerEmail: String?
    let showAddress: Bool?
    let showEmail: Bool?
    let showReceipt: Bool?
    let shippingCountry: String?
    let shippingCityName: String?
    let shippingStreetName: String?
    let shippingPostCode: String?
    let billingCountry: String?
    let billingCityName: String?
    let billingStreetName: String?
    let billingPostCode: String?
    let environment: String?
    // Function to save Configuration to UserDefaults
       func saveToUserDefaults() {
           do {
               let encodedData = try JSONEncoder().encode(self)
               UserDefaults.standard.set(encodedData, forKey: "configuration")
               UserDefaults.standard.synchronize();
           } catch {
               print("Error saving configuration: \(error)")
           }
       }
       
       // Function to retrieve Configuration from UserDefaults
       static func loadFromUserDefaults() -> Configuration? {
           guard let encodedData = UserDefaults.standard.data(forKey: "configuration") else {
               return nil
           }
           do {
               let configuration = try JSONDecoder().decode(Configuration.self, from: encodedData)
               return configuration
           } catch {
               print("Error decoding configuration: \(error)")
               return nil
           }
       }
}
