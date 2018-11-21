//
//  viewFriendsOrderViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/20/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

//protocol - where you are in + "Delegate". Extension = where you are : what properties you want to inherit
protocol ViewFriendsOrderViewControllerDelegate : class {
    func backPressed()
}

class viewFriendsOrderViewController: UIViewController {

    //outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var sidesLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var specialInstructionsLabel: UILabel!
    @IBOutlet weak var restaurantLogoImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    //variables
    var delegate : ViewFriendsOrderViewControllerDelegate?
    var orderInfo : [String : String] = [:]
    
    //over ride functions
    //viewDidLoad - only loads once
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //viewWillAppear runs every time you open VC
    override func viewWillAppear(_ animated: Bool) {
        mainLabel.text = orderInfo["Main"]
        baseLabel.text = orderInfo["Base"]
        ingredientsLabel.text = orderInfo["Ingredients"]
        sidesLabel.text = orderInfo["Sides"]
        specialInstructionsLabel.text = orderInfo["Special Instructions"]
    }
    
    //buttons
    @IBAction func backPressed(_ sender: UIButton) {
        delegate?.backPressed()
    }

}
