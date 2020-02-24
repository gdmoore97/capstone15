//
//  ViewController.swift
//  SmartTV
//
//  Created by user160653 on 2/14/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    // picker array
    let roles = ["Owner", "Caregiver"]
    
    // declare the UIPickerView
   var picker = UIPickerView()
    
    
    // UI objects
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var roleTxt: UITextField!
    
    // picker functions
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return roles.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return roles[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            roleTxt.text = roles[row]
       }
 
    
    // create alert controller
    func createAlert (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        roleTxt.inputView = picker
        
    }

    // register button clicked
    @IBAction func register_click(_ sender: Any) {
        
        // if no text was entered
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || firstNameTxt.text!.isEmpty || lastNameTxt.text!.isEmpty || roleTxt.text!.isEmpty {
            
            // enforce red placeholders
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            firstNameTxt.attributedPlaceholder = NSAttributedString(string: "first", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            lastNameTxt.attributedPlaceholder = NSAttributedString(string: "last", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            roleTxt.attributedPlaceholder = NSAttributedString(string: "role", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
        // if text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // ** create a new user in MySQL **
            
            // url to php file
            let url = URL(string: "http://smartersmarttv.com/tv_register.php")!
            
            // request to the file
            var request = URLRequest(url: url)
            
            // method to pas data to this file
            request.httpMethod = "POST"
            
            // body to be appended to url
            let body = "username=\(usernameTxt.text!.lowercased())&password=\(passwordTxt.text!)&fullname=\(firstNameTxt.text!)%20\(lastNameTxt.text!)&role=\(roleTxt.text!)"
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            // process request
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    // get main queue in code to proceed to communicate back to the UI
                    DispatchQueue.main.async(execute: {
                        
                        do {
                            // get json result
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            // assign json to new var parseJSON in secured way
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            // get id from parseJSON dictionary
                            let id = parseJSON["id"]
                            
                            // successfully registered
                            if id != nil {
                                
                                // save user info we recieved from out host
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                
                                //user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                
                                // go to home page
                                DispatchQueue.main.async(execute: {
                                 //   //AppDelegate.login()
                                })
                                
                            // error
                            } else {
                                
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    let message = parseJSON["message"] as! String
                                    self.createAlert(title: "Error", message: message)
                                })
                                return
                                
                            }
                            
                        } catch {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                let message = "\(error)"
                                self.createAlert(title: "Error", message: message)
                                
                            })
                            return
                            
                        }
                        
                    })
                
                //if unable to process request
                
                
                } else {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                       let message = error!.localizedDescription
                       self.createAlert(title: "Error", message: message)
                        
                    })
                    return
                }
            
            // launch prepared session
            
                } .resume()
    }
    
  }

}













