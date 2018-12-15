//
//  whoOrderedViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/20/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit
import Contacts
import CoreData

class whoOrderedViewController: UIViewController {

    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var tableData : [FriendsOrder] = []
    var contactTableData : [ContactsForOrder] = []
    var contactsSelected : [CNContact]?
    var selectedContactsDict : [String : String] = [:]
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //over rides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchContactItems()
        
        for contact in contactTableData{
        }
    }
    
    //button
    @IBAction func sendLastCallPressed(_ sender: UIButton) {
    }
    
    //other functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! viewFriendsOrderViewController
        dest.delegate = self
        
        if let indexPath = sender as? IndexPath{
            dest.orderInfo = [
                "Main" : tableData[indexPath.row].main,
                "Base" : tableData[indexPath.row].base,
                "Ingredients" : tableData[indexPath.row].ingredients,
                "Sides" : tableData[indexPath.row].sides,
                "Special Instructions" : tableData[indexPath.row].specialInstructions,
                "Restaurant" : tableData[indexPath.row].restaurant
                ] as! [String : String]
        }
    }
    
    
    func fetchContactItems(){
        let request: NSFetchRequest<ContactsForOrder> = ContactsForOrder.fetchRequest()
        do {
            contactTableData = try context.fetch(request)
        }
        catch{
            print("\(error)")
        }
    }
    
    
    
    
}

extension whoOrderedViewController : FriendsOrderCellDelegate {
    func statusPressed(sender: FriendsOrderCell) {
        // going to change later based on image
        performSegue(withIdentifier: "FriendsOrderSegue", sender: sender)
    }
}

//Table Stuff
extension whoOrderedViewController  : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsOrderCell", for: indexPath) as! FriendsOrderCell
        let contact = contactTableData[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        cell.contactNameLabel.text = contact.givenName! + " " + contact.familyName!
        print(contact.givenName! + " " + contact.familyName!)
        cell.confirmedOrderImageView.image = UIImage(named: "")
        return cell
    }
}

extension whoOrderedViewController : ViewFriendsOrderViewControllerDelegate{
    func backPressed() {
        dismiss(animated: true, completion: nil)
    }

}
