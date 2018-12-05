//
//  settingsViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/28/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {

    //outlet
    @IBOutlet weak var tableView: UITableView!

    //variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //buttons
    @IBAction func ordersPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToOrdersViewController", sender: self)
    }
    
    //functions
    
}

//table stuff
extension settingsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        cell.indexPath = indexPath
        
        if indexPath.row == 0{
            cell.settingsLabel.text = "Contacts"
        }
        else if indexPath.row == 1{
           cell.settingsLabel.text = "Locations"
        }
        else if indexPath.row == 2{
            cell.settingsLabel.text = "Notifications"
        }
        else if indexPath.row == 3{
            cell.settingsLabel.text = "Delete my account"
        }
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("arrowPressed")
        performSegue(withIdentifier: "SettingsDetailsSegue", sender: indexPath)
    }
    
}
