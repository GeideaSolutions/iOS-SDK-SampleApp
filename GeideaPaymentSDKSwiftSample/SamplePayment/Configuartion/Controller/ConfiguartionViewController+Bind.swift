//
//  ConfiguartionViewController+Bind.swift
//  GeideaPaymentSDKSwiftSample
//
//  Created by Saiempu Stephy on 13/06/23.
//

import UIKit
import GeideaPaymentSDK

extension ConfiguartionViewController {
    
    func setupDemoData() {
        setUPcredentials()
        setupCurrency()
        setupCallbackUrl()
        setupDetails()
    }
    
    func setUPcredentials() {
        merchantKey.text = ""
        passwordKey.text = ""
    }
    
    func setupCurrency() {
        currencyTextField.text = "EGP"
    }
    
    func setupCallbackUrl() {
        callBackUrlTextField.text = "https://api-test.gd-azure-dev.net/external-services/api/v1/callback/test123"
        viewModel.callBackUrl = callBackUrlTextField.text
    }
    
    func setupDetails() {
        if let config = Configuration.loadFromUserDefaults() {
            customerEmailTextField.text = config.customerEmail
            merchantReferenceTextField.text = config.merchantID
            currencyTextField.text = config.currency
            callBackUrlTextField.text = config.callBackUrl
            merchantKey.text = config.merchantKey
            passwordKey.text = config.merchantPassword
            initiatedTextField.text = config.initiatedBy
            customerEmailTextField.text = config.customerEmail
            firstCheckBox.selected = config.showReceipt ?? false
            secondCheckBox.selected = config.showEmail ?? false
            thirdCheckBox.selected = config.showAddress ?? false
            
            
            
            shippingCountryTextField.text = config.shippingCountry
            shippingCityNameTextField.text = config.shippingCityName
            shippingStreetNameTextField.text = config.shippingStreetName
            shippingPostCodeTextField.text = config.shippingPostCode
            
            billingCountryTextField.text = config.billingCountry
            billingCityNameTextField.text = config.billingCityName
            billingStreetNameTextField.text = config.billingStreetName
            billingPostCodeTextField.text = config.billingPostCode
            let list  = environmentList.filter { env in
                env.name == config.environment
            }
            let env = list.first ?? Environment.uae_production
            selectedEnvironment = env
            updateEnvironment()
        } else {
            customerEmailTextField.text = "somemail@end.com"
            merchantReferenceTextField.text = "1234"
            shippingCountryTextField.text = "GBR"
            shippingCityNameTextField.text = "London"
            shippingStreetNameTextField.text = "London 1, address"
            shippingPostCodeTextField.text = "12345"
            
            billingCountryTextField.text = "SAU"
            billingCityNameTextField.text = "Riadh"
            billingStreetNameTextField.text = "Riadh 1, address "
            billingPostCodeTextField.text = "123456"
        }
        let shippingAddress = GDAddress(withCountryCode: shippingCountryTextField.text, andCity: shippingCityNameTextField.text, andStreet: shippingStreetNameTextField.text, andPostCode: shippingPostCodeTextField.text)
        let billingAddress = GDAddress(withCountryCode: billingCountryTextField.text, andCity: billingCityNameTextField.text, andStreet: billingStreetNameTextField.text, andPostCode: billingPostCodeTextField.text)
        let customerDetails = GDCustomerDetails(withEmail: customerEmailTextField.text, andCallbackUrl: callBackUrlTextField.text, merchantReferenceId: merchantReferenceTextField.text, shippingAddress: shippingAddress, billingAddress: billingAddress, paymentOperation: .NONE)
        viewModel.customerDetails = customerDetails
    }
}
