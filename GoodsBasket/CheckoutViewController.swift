//
//  CheckoutViewController.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var totalLabel: UILabel!
    public var total: Double!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var pickerToolbar: UIToolbar!
    private lazy var selectedCurrency: String = "USD"
    private lazy var allCurrencies: Dictionary<String, String> = ["USD" : "US Dollar"]
    private lazy var currencyList: Array<Any> = ["USD"]
    private lazy var currencyNamesList: Array<Any> = ["US Dollar"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.isHidden = true
        self.pickerToolbar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let totalFormattedString = String(format: "%.2f", total)
        totalLabel.text = "$\(totalFormattedString)"
    }

    @IBAction func changeCurrency() {
        let apiManager = CurrencyService.shared()
        spinner.isHidden = false
        spinner.startAnimating()
        apiManager.getCurrencyList { (response) in
            let currencies = response[.currencies] as! Dictionary<String, Any>
            self.currencyList = Array(currencies.keys)
            self.currencyNamesList = Array(currencies.values)
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.pickerView.reloadAllComponents()
                self.pickerView.isHidden = false
                self.pickerToolbar.isHidden = false
            }
        }
    }

    //MARK: - UIPIckerViewDataSource methods
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (currencyNamesList[row] as! String)
    }
    
    //MARK: - UIPIckerView Delegate methods
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyList[row] as! String
    }
    
    @IBAction func selectCurrency(_ sender: Any) {
        currency.text = selectedCurrency
        pickerView.isHidden = true
        self.pickerToolbar.isHidden = true
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        let apiManager = CurrencyService.shared()
        apiManager.getCurrencyValue(amount: total, toCurrency: selectedCurrency) { (result) in
            let totalFormattedString = String(format: "%.2f", result)
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.totalLabel.text = "$\(totalFormattedString)"
            }
        }
    }
}
