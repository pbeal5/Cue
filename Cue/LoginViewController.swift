//
//  ViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/15/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import Foundation
import UIKit


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        
        //Start on second view controller after login
        mainTabController.selectedViewController = mainTabController.viewControllers?[1]
        
        
        present(mainTabController, animated: true, completion: nil)
        
        
    }

    

}
