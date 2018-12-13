//
//  CurrencyService.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import UIKit

class CurrencyService: NSObject {

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
}
