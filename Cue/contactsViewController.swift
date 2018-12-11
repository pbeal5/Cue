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
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    //variables
    var logo = ""
    var delegate : contactsViewControllerDelegate?
    var contacts : [CNContact] = []
    var filteredContacts : [CNContact] = []
    var isSelected: [Bool] = []
    var selectedContactsDict : [String : String] = [:]
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        contactSearchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchContacts()
        filteredContacts = contacts
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
        
        alert?.addAction(UIAlertAction(title: "No, all good.", style: .default, handler: {action in
            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
            mainTabController.selectedViewController = mainTabController.viewControllers?[2]
            
//            let vc = self.tabBarController?.viewControllers![2] as? whoOrderedViewController
//            vc?.contactsSelected = self.contacts
        
        // store firstName, lastName, identifier
            
            
//            var destTab = self.tabBarController?.viewControllers?[2] as whoOrderedViewController
//            destTab.con = firstArray
//
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

    //functions

}

//table stuff
extension contactsViewController : UITableViewDelegate, UITableViewDataSource {
    
    //Need both of these functions for every table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for : indexPath) as! ContactCell
        
        if let val = selectedContactsDict[filteredContacts[indexPath.row].identifier] {
            cell.contactSelected.setBackgroundImage(UIImage(named: "filledCircle"), for: .normal)
        }
        else{
           cell.contactSelected.setBackgroundImage(UIImage(named: "emptyCircle"), for: .normal)
        }
        
        cell.contactNameLabel.text = filteredContacts[indexPath.row].givenName + " " + filteredContacts[indexPath.row].familyName
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
        
        let contact = sender.indexPath?.row

        if isSelected[contact!]{
            selectedContactsDict.removeValue(forKey: filteredContacts[contact!].identifier)
        }
        else {
            selectedContactsDict[filteredContacts[contact!].identifier] = filteredContacts[contact!].identifier
        }
        
        isSelected[contact!] = !isSelected[contact!]
        
    }
    
}

extension contactsViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContacts = searchText.isEmpty ? contacts : contacts.filter { (item: CNContact) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.givenName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ||
                item.familyName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}

