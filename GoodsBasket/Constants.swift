//
//  Constants.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//


extension String {
    
    //UI IDs
    static let itemCellID = "itemCell"
    static let checkoutSegue = "checkoutSegue"

    //Currency API Service URL and API Key and endpoints
    static let apiKey = "6de88fe8b94d5424d5380dff85e0eae3"
    static let baseURL = "http://apilayer.net/api"
    static let liveConversion = "/live"
    static let currencyList = "/list"
    
    //Dictionary keys
    static let unit = "unit"
    static let price = "price"
    static let item = "item"
    static let peas = "Peas"
    static let eggs = "Eggs"
    static let milk = "Milk"
    static let beans = "Beans"
    static let currencies = "currencies"
    static let exchangeValues = "quotes"
}

extension Double{
    public static let peasPrice = 0.95
    public static let eggsPrice = 2.10
    public static let milkPrice = 1.12
    public static let beansPrice = 0.73
}

func availableItems() -> Array<Any> {
    return [["item" : "Peas", "unit": "Bag", "price" : 0.95],
            ["item" : "Eggs", "unit": "Dozen", "price" : 2.10],
            ["item" : "Milk", "unit": "Bottle", "price" : 1.12],
            ["item" : "Beans", "unit": "Can", "price" : 0.73]]
}
