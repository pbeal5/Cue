//
//  friendsOrderCell.swift
//  Cue
//
//  Created by Patrick Beal on 11/20/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

protocol FriendsOrderCellDelegate : class {
    func statusPressed(sender : FriendsOrderCell)
}


class FriendsOrderCell : UITableViewCell{
    
    //outlet
    @IBOutlet weak var contactNameLabel: UILabel!
    
    @IBOutlet weak var statusButton: UIButton!
    
    //variables
    var indexPath : IndexPath?
    var delegate : FriendsOrderCellDelegate?
    
    //button
    @IBAction func statusPressed(_ sender: UIButton) {
        delegate?.statusPressed(sender : self)
    }
    
}
