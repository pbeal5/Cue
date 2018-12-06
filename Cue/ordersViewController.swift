//
//  ordersViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/17/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit
import CoreData

class ordersViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    //Defining variables
    var tableData: [Order] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this only runs once, on page load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //this allows us to continually update
    override func viewWillAppear(_ animated: Bool) {
        fetchOrderItems()
        tableView.reloadData()
    }
    
    //buttons
    @IBAction func settingsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SettingsSegue", sender: sender)
        
    }
    
    @IBAction func makeOrderPressed(_ sender: UIButton) {
        //This will create segue between "make new order button" and Make Order View Controller
        performSegue(withIdentifier: "makeOrderSegue", sender: sender)
    }
    
    @IBAction func unwindToOrdersViewController(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //set the destination as a var for wherever its going
        
        var destination : UIStoryboardSegue?
        
//        if segue.identifier == "SettingsSegue" {
//            destination = segue.destination as! settingsViewController
        
        if let destination = segue.destination as? settingsViewController {
            print("Settings")
            
        }
        else if let destination = segue.destination as? makeOrderViewController {
            
            if let indexPath = sender as? IndexPath{
//                print(indexPath.row)
//                print(tableData[indexPath.row])
                destination.indexPath = indexPath
                destination.orderInfo["Main"] = tableData[indexPath.row].main
                destination.orderInfo["Base"] = tableData[indexPath.row].base
                destination.orderInfo["Ingredients"] = tableData[indexPath.row].ingredients
                destination.orderInfo["Sides"] = tableData[indexPath.row].sides
                destination.orderInfo["Special Instructions"] = tableData[indexPath.row].specialInstructions
            }
            else{
                destination.orderInfo["Main"] = "Main"
                destination.orderInfo["Base"] = "Base"
                destination.orderInfo["Ingredients"] = "Ingredients"
                destination.orderInfo["Sides"] = "Sides"
                destination.orderInfo["Special Instructions"] = "Special Instructions"
            }

            destination.delegate = self
        }
    
    }

    func fetchOrderItems(){
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        do {
            tableData = try context.fetch(request)
        }
        catch{
            print("\(error)")
        }
    }
    
}

extension ordersViewController : makeOrderViewControllerDelegate{
    
    func backPressed() {
//        print("back pressed")
        dismiss(animated: true, completion: nil)
    }
    
    func saveOrderPressed(orderInfo : [String : String], indexPath : IndexPath?) {
        
        if let indexPath = indexPath{
            let order = tableData[indexPath.row]
            order.main = orderInfo["Main"]
            order.base = orderInfo["Base"]
            order.ingredients = orderInfo["Ingredients"]
            order.sides = orderInfo["Sides"]
            order.specialInstructions = orderInfo["Special Instructions"]
            order.restaurant = orderInfo["Restaurant"]
        }
            
        else {
            let order = Order(context: context)
            order.main = orderInfo["Main"]
            order.base = orderInfo["Base"]
            order.ingredients = orderInfo["Ingredients"]
            order.sides = orderInfo["Sides"]
            order.specialInstructions = orderInfo["Special Instructions"]
            order.restaurant = orderInfo["Restaurant"]
            
            tableData.append(order)
        }
            
        do{
            try context.save()
        }
        catch{
            print("\(error)")
        }
        
        dismiss(animated: true, completion: nil)
        
//        print(orderInfo)
        
    }
}

//Table Stuff
extension ordersViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        let order = tableData[indexPath.row]
        if order.restaurant == "Chipotle"{
           cell.restaurantButton.setBackgroundImage(UIImage(named: "chipotle"), for: .normal)
        }
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete"){ (action, view, handler) in
            let order = self.tableData[indexPath.row]
            self.context.delete(order)
            do{
                try self.context.save()
            }
            catch{
                print("\(error)")
            }
            self.tableData.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "makeOrderSegue", sender: indexPath)
    }
}

extension ordersViewController: OrderCellDelegate{
   
    func restaurantPressed(sender: OrderCell) {
        print("We don't give a damn for the whole state of Xichigan")
//        performSegue(withIdentifier: "makeOrderSegue", sender: sender.indexPath)
    }
}

