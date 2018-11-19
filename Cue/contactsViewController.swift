//
//  contactsViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/18/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit
import Contacts

protocol contactsViewControllerDelegate : class {
    func backPressed()
    func cueUpPressed()
}

class contactsViewController: UIViewController {

    //outlets
    @IBOutlet weak var restaurantLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var logo = ""
    var delegate : contactsViewControllerDelegate?
    var contacts: [CNContact] = []
    var isSelected: [Bool] = []
    
    //viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchContacts()
        tableView.reloadData()
    }
    
    //fetch contacts function 
    func fetchContacts(){
        let contactStore = CNContactStore()
        do {
            try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactMiddleNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor])) {
                (contact, cursor) -> Void in
                self.contacts.append(contact)
                self.isSelected.append(false)
            }
        }
        catch{
            print("Handle the error please")
        }
    }
    
    //buttons
    @IBAction func cueUpPressed(_ sender: UIButton) {
        
        var count = 0
        
        for i in 0..<isSelected.count{
            if isSelected[i]{
                print(contacts[i])
                count += 1
            }
        }
        
        var alert : UIAlertController?
        
        if count == 1{
            alert = UIAlertController(title: "You've selected \(count) person.", message: "Do you want to add more?", preferredStyle: .alert)
        }
        else{
            alert = UIAlertController(title: "You've selected \(count) people.", message: "Do you want to add more?", preferredStyle: .alert)
        }
        
        alert?.addAction(UIAlertAction(title: "Yes, add more", style: .cancel, handler: nil))
        
        alert?.addAction(UIAlertAction(title: "No, all good.", style: .default, handler: {(UIAlertAction) in
            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
            mainTabController.selectedViewController = mainTabController.viewControllers?[2]
            self.present(mainTabController, animated: true, completion: nil)
        }))
        
        self.present(alert!, animated: true)
    }
    
    @IBAction func contactsPressed(_ sender: UIButton) {
    }
    @IBAction func groupsPressed(_ sender: UIButton) {
    }
    @IBAction func backPressed(_ sender: UIButton) {
        delegate?.backPressed()
    }

}

//table stuff
extension contactsViewController : UITableViewDelegate, UITableViewDataSource {
    
    //Need both of these functions for every table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.contactNameLabel.text = contacts[indexPath.row].givenName + " " + contacts[indexPath.row].familyName
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    //setting row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}

//extending what you are in to what you want to bring in
extension contactsViewController : ContactCellDelegate{
    
    func selectedPressed(sender: ContactCell) {
        isSelected[(sender.indexPath?.row)!] = !isSelected[(sender.indexPath?.row)!]
        print("in selectedPressed")
    }
    
}
