//
//  ViewController.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var badge: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - UITableViewDatasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "itemCell"
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID) as! UITableViewCell
        return cell
    }

    //MARK: - UITableViewDelegate methods
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

