//
//  ItemTableViewCell.swift
//  GoodsBasket
//
//  Created by Angel on 12/12/18.
//  Copyright © 2018 Angel Wingartz. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var itemAmount: UILabel!
    @IBOutlet weak var itemsNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didSelectLessItems() {
        var items = Int(itemsNumber.text!)
        if items! > 0{
            items = items! - 1
            itemsNumber.text = "\(items ?? 1)"
        }
    }
    
    @IBAction func didSelectMoreItems() {
        var items = Int(itemsNumber.text!)
        if items! < 100{
            items = items! + 1
            itemsNumber.text = "\(items ?? 1)"
        }
    }
}
