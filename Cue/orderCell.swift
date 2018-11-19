//
//  orderCell.swift
//  Cue
//
//  Created by Patrick Beal on 11/17/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

protocol OrderCellDelegate: class{
    func restaurantPressed(sender: OrderCell)
}

class OrderCell: UITableViewCell{
    
    @IBOutlet weak var restaurantButton: UIButton!
    
    
    @IBAction func restaurantPressed(_ sender: UIButton) {
        delegate?.restaurantPressed(sender: self)
    }
    
    var delegate: OrderCellDelegate?
    var indexPath: IndexPath?
}
