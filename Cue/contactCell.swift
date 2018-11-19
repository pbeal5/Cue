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
    
    @IBOutlet weak var contactSelected: UIButton!
    
    @IBAction func contactPressed(_ sender: UIButton) {
        if contactSelected.backgroundImage(for: .normal) == UIImage(named: "emptyCircle"){
            contactSelected.setBackgroundImage(UIImage(named: "filledCircle"), for : .normal)
        }
        else{
           contactSelected.setBackgroundImage(UIImage(named: "emptyCircle"), for : .normal)
        }
        
        delegate?.selectedPressed(sender : self)
        
    }
    
}
