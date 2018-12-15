//
//  contactsViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/18/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit
import Contacts
import CoreData

protocol contactsViewControllerDelegate : class {
    func backPressed()
    func cueUpPressed()
}

class contactsViewController: UIViewController {

    //outlets
    @IBOutlet weak var restaurantLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contactSearchBar: UISearchBar!
    @IBOutlet weak var cueUpPressedText: UIButton!
    
    //variables
    var logo = ""
    var delegate : contactsViewControllerDelegate?
    var contacts : [CNContact] = []
    var filteredContacts : [CNContact] = []
    var isSelected: [Bool] = []
    var selectedContactsDict : [String : ContactsForOrder] = [:]
    var tableData : [ContactsForOrder] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count = 0
    
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
        contacts = contacts.sorted { $0.familyName < $1.familyName }
        filteredContacts = contacts
        tableView.reloadData()
    }
    
    //fetch contacts function 
    func fetchContacts(){

//        fetchContacts.sortOrder = CNContactSortOrder.UserDefault

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
        
//            //find the contacts that are selected and send to core data
//            for j in 0..<self.contacts.count{
//                if self.isSelected[j]{
//                    var changeType : ContactsForOrder?
//                    changeType?.identifier = self.contacts[j].identifier
//                    changeType?.givenName = self.contacts[j].givenName
//                    changeType?.familyName = self.contacts[j].familyName
//                    self.tableData.append(changeType!)
//                }
//            }
//
//            do{
//                try self.context.save()
//            }
//            catch{
//                print("\(error)")
//            }

        let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabController.selectedViewController = mainTabController.viewControllers?[2]
        self.present(mainTabController, animated: true, completion: nil)
    }
    
    //buttons
    @IBAction func contactsPressed(_ sender: UIButton) {
    }
    @IBAction func groupsPressed(_ sender: UIButton) {
    }
    @IBAction func backPressed(_ sender: UIButton) {
        delegate?.backPressed()
    }

    //functions
    
    func fetchContactItems(){
        let request: NSFetchRequest<ContactsForOrder> = ContactsForOrder.fetchRequest()
        do {
            tableData = try context.fetch(request)
        }
        catch{
            print("\(error)")
        }
    }

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
            cell.contactSelectedImageView.image = UIImage(named: "filledCircle")
        }
        else{
           cell.contactSelectedImageView.image = UIImage(named: "emptyCircle")
        }
        
        cell.contactNameLabel.text = filteredContacts[indexPath.row].givenName + " " + filteredContacts[indexPath.row].familyName
        cell.indexPath = indexPath
        return cell
    }
    
    //setting row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    //selected rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let contact = indexPath.row
        
        let cell = self.tableView.cellForRow(at: indexPath) as! ContactCell
        
        if cell.contactSelectedImageView.image == UIImage(named: "filledCircle"){
            cell.contactSelectedImageView.image = UIImage(named: "emptyCircle")
            count = count - 1
//            selectedContactsDict.removeValue(forKey: filteredContacts[contact].identifier)
        }
        else{
            cell.contactSelectedImageView.image = UIImage(named: "filledCircle")
            count = count + 1
//            var combinedEntry : ContactsForOrder?
//            combinedEntry?.identifier = filteredContacts[contact].identifier
//            combinedEntry?.givenName = filteredContacts[contact].givenName
//            combinedEntry?.familyName = filteredContacts[contact].familyName
//            selectedContactsDict[filteredContacts[contact].identifier] = combinedEntry
//
//            print(selectedContactsDict[filteredContacts[contact].identifier])
            
//            selectedContactsDict[filteredContacts[contact].identifier]?.givenName = filteredContacts[contact].givenName
//            selectedContactsDict[filteredContacts[contact].identifier]?.familyName = filteredContacts[contact].familyName
        }
        
        UIView.setAnimationsEnabled(false)
        
        if count == 1{
            cueUpPressedText.setTitle("Cue up \(count) order", for: .normal)
            
        }
        else{
             cueUpPressedText.setTitle("Cue up \(count) orders", for: .normal)
        }
        
        
       
        isSelected[contact] = !isSelected[contact]


       
//        if let val = selectedContactsDict[filteredContacts[contact].identifier] {
//            contacts[contact].contactSelectedImageView.image = UIImage(named: "filledCircle")
//        }
//        else{
//            contacts[contact].contactSelectedImageView.image = UIImage(named: "emptyCircle")
//        }
//
//        if isSelected[contact]{
//            selectedContactsDict.removeValue(forKey: filteredContacts[contact].identifier)
//        }
//        else {
//            selectedContactsDict[filteredContacts[contact].identifier] = filteredContacts[contact].identifier
//        }
        
//        isSelected[contact] = !isSelected[contact]
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

