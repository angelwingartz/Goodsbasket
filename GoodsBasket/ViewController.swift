//
//  ViewController.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ItemCellAmountDelegate{
    
    @IBOutlet weak var badge: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    private lazy var badgeCount: Int = 0
    private lazy var peaBags: Int = 0
    private lazy var eggDozens: Int = 0
    private lazy var milkBottles: Int = 0
    private lazy var beanCans: Int = 0
    private lazy var grandTotal: Double = 0
    private lazy var basketItems: Array<Any> = availableItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This will help with the Unit testing
        tableView.accessibilityIdentifier = "tableID"
        updateBadge()
    }

    //MARK: - UITableViewDatasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: .itemCellID) as! ItemTableViewCell
        let itemInfo:Dictionary = basketItems[indexPath.row] as! Dictionary<String, Any>
        cell.item.text = (itemInfo[.item] as! String)
        cell.itemAmount.text = "$\(itemInfo[.price] ?? 0.00)"
        cell.unit.text = "a " + (itemInfo[.unit] as! String)
        //This will let us know what item corresponds to this cell
        cell.itemCellType = (itemInfo[.item] as! String)
        cell.delegate = self
        //This property will let us know what button to tap when doing UI automated tests
        cell.plusButton.accessibilityIdentifier = "itemCellPlus_\(indexPath.row)"
        return cell
    }

    //MARK: - UITableViewDelegate methods
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Delegate method for Number and type of items selected
    
    func didChangeItems(itemsNumber: Int, itemType: String) {
        switch itemType {
        case .peas:
            peaBags = itemsNumber
            break
        case .eggs:
            eggDozens = itemsNumber
            break
        case .milk:
            milkBottles = itemsNumber
            break
        case .beans:
            beanCans = itemsNumber
            break
        default:
            print("Uknown option O_o")
        }
        updateBadge()
    }
    
    //MARK: - Update bar button item badge for number of purchased items
    
    func updateBadge(){
        badgeCount = peaBags + eggDozens + milkBottles + beanCans
        if badgeCount == 0{
            badge.title = ""
        }
        else{
            badge.title = "\(badgeCount)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .checkoutSegue{
            let peasPrice = (basketItems[0] as! Dictionary<String, Any>)[.price] as! Double
            let eggsPrice = (basketItems[1] as! Dictionary<String, Any>)[.price] as! Double
            let milkPrice = (basketItems[2] as! Dictionary<String, Any>)[.price] as! Double
            let beansPrice = (basketItems[3] as! Dictionary<String, Any>)[.price] as! Double

            grandTotal = (peasPrice)*Double(peaBags) +
                         (eggsPrice)*Double(eggDozens) +
                        (milkPrice)*Double(milkBottles) +
                        (beansPrice)*Double(beanCans)
            let checkoutVC = segue.destination as! CheckoutViewController
            checkoutVC.total = grandTotal
        }
    }
    

    @IBAction func checkoutNow(_ sender: Any) {
        if badgeCount == 0 {
            let alert = UIAlertController.init(title: "Empty Basket", message: "Please add items to the basket bofore checking out, you can do so using the + and - buttons located at the right of each item name", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: .checkoutSegue, sender: self)
        }
    }
}

