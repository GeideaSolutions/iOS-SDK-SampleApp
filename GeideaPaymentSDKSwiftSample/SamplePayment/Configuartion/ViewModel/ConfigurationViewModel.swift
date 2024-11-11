//
//  ConfigurationViewModel.swift
//  GeideaPaymentSDKSwiftSample
//
//  Created by Saiempu Stephy on 13/06/23.
//

import Foundation
import GeideaPaymentSDK

protocol ConfigurationPresentable {
    func updateCredentials(key: String?, password: String?)
    func saveAmount(amount: String?)
    var amount: GDAmount? { get set }
    var merchantID: String? { get set }
    var initiatedBy: String? { get set }
    var merchantConfig: GDConfigResponse? { get set }
    var callBackUrl: String? { get set }
    var customerDetails: GDCustomerDetails? { get set }
    var showAddress: Bool? { get set }
    var showEmail: Bool? { get set }
    var showReceipt: Bool? { get set }
    var key: String? { get set }
    var password: String? { get set }
    var selectedCurrency: String? { get set }
    func refreshConfig()
}

class ConfigurationViewModel: ConfigurationPresentable {
    var merchantConfig: GDConfigResponse?
    var amount: GDAmount?
    var callBackUrl: String?
    var customerDetails: GDCustomerDetails?
    var key: String?
    var password: String?
    var merchantID: String?
    var initiatedBy: String?
    var showAddress: Bool? = false
    var showEmail: Bool? = false
    var showReceipt: Bool? = false
    var selectedCurrency: String?
    init() {
        self.loadMerchantConfig()
    }
    func updateCredentials(key: String?, password: String?) {
        guard let publicKey = key, let password = password, !publicKey.isEmpty, !password.isEmpty else {
            return
        }
        self.key = key
        self.password = password
        GeideaPaymentAPI.setCredentials(withMerchantKey: publicKey, andPassword: password)
        refreshConfig()
    }
    
    func saveAmount(amount: String?) {
        guard let safeAmount = Double(amount ?? "") else {
            return
        }
        let amount = GDAmount(amount: safeAmount, currency: selectedCurrency ?? "SAR")
        self.amount = amount
    }
    
    func saveCustomerDetails(customer: GDCustomerDetails) {
        self.customerDetails = customer
    }
    
    func refreshConfig() {
        GeideaPaymentAPI.getMerchantConfig(completion:{ response, error in
            guard let config = response else {
                self.merchantConfig = nil
                return
            }
            self.merchantConfig = config
        })
    }
    
    func checkConfiguartionDetailsAvailability() -> Bool {
        if customerDetails == nil {
            return false
        }
        return true
    }
    
    func loadMerchantConfig() {
        guard let config = Configuration.loadFromUserDefaults() else {
            return;
        }
        let shippingAddress = GDAddress(withCountryCode: config.shippingCountry, andCity: config.shippingCityName, andStreet: config.shippingStreetName, andPostCode: config.shippingPostCode)
        let billingAddress = GDAddress(withCountryCode: config.billingCountry, andCity: config.billingCityName, andStreet: config.billingStreetName, andPostCode: config.billingPostCode)
        let customerDetails = GDCustomerDetails(withEmail: config.customerEmail, andCallbackUrl: config.callBackUrl, merchantReferenceId: config.merchantID, shippingAddress: shippingAddress, billingAddress: billingAddress, paymentOperation: .NONE)
        self.customerDetails = customerDetails
        self.callBackUrl =  "https://api-test.gd-azure-dev.net/external-services/api/v1/callback/test123"
        let list  = Environment.allCases.filter { env in
            env.name == config.environment
        }
        
        let env = list.first ?? Environment.uae_production
        GeideaPaymentAPI.setEnvironment(environment: env)
        let savedLanguageIndex = UserDefaults.standard.integer(forKey: "language")
        
        switch savedLanguageIndex {
        case 1:
            GeideaPaymentAPI.setlanguage(language: Language.arabic)
        default:
            GeideaPaymentAPI.setlanguage(language: Language.english)
        }
        self.selectedCurrency = config.currency
        self.initiatedBy = config.initiatedBy
        self.updateCredentials(key: config.merchantKey, password: config.merchantPassword)
        refreshConfig()
    }
}
