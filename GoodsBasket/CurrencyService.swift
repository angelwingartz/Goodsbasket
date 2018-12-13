//
//  CurrencyService.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import UIKit

class CurrencyService: NSObject {

    //Singleton pattern implementation for the API transaction manager
    private static var sharedManager: CurrencyService = {
        let manager = CurrencyService()
        return manager
    }()
    class func shared() -> CurrencyService {
        return sharedManager
    }
    
    private override init() {
        //Custom init
        
    }
    
    public func getCurrencyList(completion:@escaping (_ result: Dictionary<String, Any>) -> Void){
        let serviceURL: String = .baseURL + .currencyList + "?access_key=" + .apiKey
        let url = URL(string: serviceURL)
        var request :URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            //Check for errors
            guard error == nil else {
                print("Error")
                return
            }
            guard let responseData = data else {
                print("Error, did not receive data")
                return
            }
            do {
                let json = try? JSONSerialization.jsonObject(with: responseData, options: [])
                completion(json as! Dictionary<String, Any>)
            }
        }
        dataTask.resume()
    }
    public func getCurrencyValue(amount: Double, toCurrency:String, completion:@escaping (_ result: Double) -> Void){
        let serviceURL: String = .baseURL + .liveConversion + "?access_key=" + .apiKey
        let url = URL(string: serviceURL)
        var request :URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            //Check for errors
            guard error == nil else {
                print("Error")
                return
            }
            guard let responseData = data else {
                print("Error, did not receive data")
                return
            }
            do {
                let json = try? JSONSerialization.jsonObject(with: responseData, options: [])
                let exchangeRates: Dictionary<String, Any> = json as! Dictionary<String, Any>
                let quotes: Dictionary<String, Any> = exchangeRates[.exchangeValues] as! Dictionary<String, Any>
                let conversionKey = "USD"+toCurrency
                let exchangeValue: Double = Double(quotes[conversionKey] as! Double)
                let conversion = exchangeValue*amount
                completion(conversion)
            }
        }
        dataTask.resume()
    }
}
