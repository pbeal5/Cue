//
//  contactCell.swift
//  Cue
//
//  Created by Patrick Beal on 11/18/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

protocol ContactCellDelegate : class {
    func selectedPressed(sender : ContactCell)
}

class ContactCell : UITableViewCell{
    
    //setup variables
    var indexPath : IndexPath?
    var delegate : ContactCellDelegate?
    
    @IBOutlet weak var contactNameLabel: UILabel!
    
    @IBOutlet weak var contactSelectedImageView: UIImageView!
    
}


