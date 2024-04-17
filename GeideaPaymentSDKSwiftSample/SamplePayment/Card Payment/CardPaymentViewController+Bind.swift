//
//  CardPaymentViewController+Bind.swift
//  GeideaPaymentSDKSwiftSample
//
//  Created by Saiempu Stephy on 14/06/23.
//

import UIKit

extension CardPaymentViewController {
    func bindData() {
        cardNumberTextField.text = ""
        cardHolderNameField.text = ""
        expiryMonthTextField.text = ""
        expiryYearTextField.text = ""
        cvvTextField.text = ""
    }
}
