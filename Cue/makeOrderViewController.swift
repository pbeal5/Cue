//
//  makeOrderControllerViewController.swift
//  Cue
//
//  Created by Patrick Beal on 11/17/18.
//  Copyright © 2018 Cue. All rights reserved.
//

import UIKit

//This file knows there is a makeOrderDelegate, and that these functions exists
protocol makeOrderViewControllerDelegate: class {
    func backPressed()
    func saveOrderPressed(orderInfo: [String : String], indexPath: IndexPath?)
}

class makeOrderViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Set placeholder text for text fields
        mainTextView.text = "Main"
        mainTextView.textColor = UIColor.lightGray
        mainTextView.delegate = self
        
        baseTextView.text = "Base"
        baseTextView.textColor = UIColor.lightGray
        baseTextView.delegate = self
        
        ingredientsTextView.text = "Ingredients"
        ingredientsTextView.textColor = UIColor.lightGray
        ingredientsTextView.delegate = self
        
        sidesTextView.text = "Sides"
        sidesTextView.textColor = UIColor.lightGray
        sidesTextView.delegate = self
        
        specialInstructionsTextView.text = "Special instructions"
        specialInstructionsTextView.textColor = UIColor.lightGray
        specialInstructionsTextView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if orderInfo["Main"] == "Main"{
            mainTextView.text = "Main"
            mainTextView.textColor = UIColor.lightGray
            mainTextView.delegate = self
            
            baseTextView.text = "Base"
            baseTextView.textColor = UIColor.lightGray
            baseTextView.delegate = self
            
            ingredientsTextView.text = "Ingredients"
            ingredientsTextView.textColor = UIColor.lightGray
            ingredientsTextView.delegate = self
            
            sidesTextView.text = "Sides"
            sidesTextView.textColor = UIColor.lightGray
            sidesTextView.delegate = self
            
            specialInstructionsTextView.text = "Special instructions"
            specialInstructionsTextView.textColor = UIColor.lightGray
            specialInstructionsTextView.delegate = self
        }
        else{
            
            mainTextView.textColor = UIColor.black
            baseTextView.textColor = UIColor.black
            ingredientsTextView.textColor = UIColor.black
            sidesTextView.textColor = UIColor.black
            specialInstructionsTextView.textColor = UIColor.black
            
            mainTextView.text = orderInfo["Main"]
            baseTextView.text = orderInfo["Base"]
            ingredientsTextView.text = orderInfo["Ingredients"]
            sidesTextView.text = orderInfo["Sides"]
            specialInstructionsTextView.text = orderInfo["Special Instructions"]
        }

    }
    
    //Establish variables
    var delegate: makeOrderViewControllerDelegate?
    var indexPath: IndexPath?
    var orderInfo: [String: String] = [:]
    
    //Connect to order text views
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var baseTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var sidesTextView: UITextView!
    @IBOutlet weak var specialInstructionsTextView: UITextView!
    @IBAction func backPressed(_ sender: UIButton) {
        delegate?.backPressed()
    }
    
    @IBAction func saveOrderPressed(_ sender: UIButton) {
        
        if mainTextView.text != "" && mainTextView.text != "Main" &&
            baseTextView.text != "" && baseTextView.text != "Base" &&
            ingredientsTextView.text != "" && ingredientsTextView.text != "Ingredients" &&
            sidesTextView.text != "" && sidesTextView.text != "Sides" &&
            specialInstructionsTextView.text != "" && specialInstructionsTextView.text != "Special Instructions"{
                //This is a dictionary for orders
                var orderInfo = ["Main": mainTextView.text as String,
                                 "Base": baseTextView.text as String,
                                 "Ingredients": ingredientsTextView.text as String,
                                 "Sides": sidesTextView.text as String,
                                 "Special Instructions": specialInstructionsTextView.text as String,
                                 "Restaurant": "Chipotle"]
            
                delegate?.saveOrderPressed(orderInfo : orderInfo, indexPath: indexPath)
    }
        else{
           let alert = UIAlertController(title: "All fields must be filled in.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//Triggering built in functions with out code, rather than default for those functions
extension makeOrderViewController: UITextViewDelegate {
    
    //If user starts typing, change text to black
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    //If the UITextView is empty, replace with Placeholder and turn light grey
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            if textView == mainTextView{
                textView.text = "Main"
            }
            else if textView == baseTextView{
                textView.text = "Base"
            }
            else if textView == ingredientsTextView{
                textView.text = "Ingredients"
            }
            else if textView == sidesTextView{
                textView.text = "Sides"
            }
            else if textView == specialInstructionsTextView{
                textView.text = "Special instructions"
            }
            
            textView.textColor = UIColor.lightGray
        }
    }
}
