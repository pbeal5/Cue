//
//  gettingFoodViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/18/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

class gettingFoodViewController: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var tableData : [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //Buttons
    @IBAction func favoritesPressed(_ sender: UIButton) {
    }
    @IBAction func allPressed(_ sender: UIButton) {
    }
    @IBAction func nearbyPressed(_ sender: UIButton) {
    }
    
    //Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! contactsViewController
        dest.delegate = self
        if let indexPath = sender as? IndexPath{
//            dest.logo = tableData[indexPath.row].name!
            dest.logo = "chipotle"
        }
        
    }
    

    
    

}

//Table stuff
extension gettingFoodViewController : UITableViewDelegate, UITableViewDataSource {
   
    //Need both of these functions for every table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableData.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
//        let restaurant = tableData[indexPath.row]
//        if restaurant.name == "Chipotle"{
//            cell.restaurantLogoImageView.image = UIImage(named: "chipotle")
//        }
        cell.indexPath = indexPath
        cell.restaurantLogoImageView.image = UIImage(named: "chipotle")
        return cell
    }
    
    //setting row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ContactSegue", sender: indexPath)
    }
}

extension gettingFoodViewController : contactsViewControllerDelegate{
    
    func backPressed() {
        dismiss(animated: true, completion: nil)
        print("back button pressed")
    }
    
    func cueUpPressed() {
        print("cue up pressed" )
    }
}
