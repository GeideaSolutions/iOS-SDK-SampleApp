//
//  ConfiguartionViewController.swift
//  GeideaPaymentSDKSwiftSample
//
//  Created by Saiempu Stephy on 07/06/23.
//

import UIKit
import GeideaPaymentSDK

class ConfiguartionViewController: UIViewController {
    
    lazy var configLabel: UILabel = {
        let label = UILabel()
        label.text = "Environment"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    
    lazy var environmentTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Select Environment",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.withImage(direction: .Right, image: UIImage(named: "gdArrow")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        return textField
    }()
    
    
    lazy var credentialsView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var merchantKey: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Merchant Key",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var passwordKey: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "API Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(clearButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var languageView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    var radioButtonArray = [RadioButton]()
    var languageArray = [UIButton]()
    var firstRadioButton = RadioButton.init()
    var secondRadioButton = RadioButton.init()
    lazy var paymentDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment Details"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var currency: UILabel = {
        let label = UILabel()
        label.text = "Currency"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Add ISO Alpha-3 Code",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var endPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Endpoints"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var callBackUrlTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Call back URL",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var returnUrlTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Return URL",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    
    lazy var paymentOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment Options"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    var checkBoxArray = [CheckBox]()
    var paymentOptionsArray = [UIButton]()
    let firstCheckBox = CheckBox(tapGestureEnable: true)
    let secondCheckBox = CheckBox(tapGestureEnable: true)
    let thirdCheckBox = CheckBox(tapGestureEnable: true)
    
    lazy var merchantReferenceTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Merchant Reference ID",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        )
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var initiatedTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Intiated By",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var customerDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer Details"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var customerEmailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Customer Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var billingAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Billing Address"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var billingStreetNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Street Name and Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var billingCityNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "City",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var billingPostCodeTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Post Code",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var billingCountryTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Country",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    let billingCheckbox = CheckBox(tapGestureEnable: true)
    var sameBillingAndShippingTitle: UIButton!
    var inputs: [UITextField]!
    
    lazy var shippingAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping Address"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var shippingStreetNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Street Name and Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var shippingCityNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "City",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var shippingPostCodeTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Post Code",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var shippingCountryTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Country",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    lazy var saveConfigButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(saveConfigButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var viewModel: ConfigurationPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Configuration"
        createPickerView()
        dismissPickerView()
        setupUI()
        scrollView.keyboardDismissMode = .onDrag
        inputs = [merchantKey, passwordKey, currencyTextField, callBackUrlTextField, returnUrlTextField, merchantReferenceTextField, customerEmailTextField, billingStreetNameTextField, billingCityNameTextField, billingPostCodeTextField, billingCountryTextField, shippingStreetNameTextField, shippingCityNameTextField, shippingPostCodeTextField, shippingCountryTextField]
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        setupDemoData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    var selectedEnvironment: Environment?
    let environmentList = Environment.allCases
}

extension ConfiguartionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func updateEnvironment() {
        if let env = selectedEnvironment {
            environmentTextField.text = env.name
            GeideaPaymentAPI.setEnvironment(environment: env)
        }
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        environmentTextField.inputView = pickerView
        updateEnvironment()
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        environmentTextField.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return environmentList.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return environmentList[row].name // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEnvironment = environmentList[row] // selected item
        updateEnvironment()
    }
}

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 18, y: 3.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        
        if(Direction.Left == direction){ // image left
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    
}
