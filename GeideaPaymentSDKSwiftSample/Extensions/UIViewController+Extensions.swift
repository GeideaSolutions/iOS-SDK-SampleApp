//
//  UIViewController+Extensions.swift
//  GeideaPaymentSDKSwiftSample
//
//  Created by euvid on 05/11/2020.
//

import Foundation
import UIKit

extension UIViewController {

    var window: UIWindow? {
     if #available(iOS 13, *) {
         guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
                return window
     }
     
     guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
     return window
 }
}

