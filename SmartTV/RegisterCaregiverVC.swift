//
//  RegisterCaregiverVC.swift
//  SmartTV
//
//  Created by user160653 on 3/3/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class RegisterCaregiverVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var firstnameTxt: UITextField!
    @IBOutlet weak var lastnameTxt: UITextField!
    @IBOutlet weak var owner_usernameTxt: UITextField!
    @IBOutlet weak var owner_firstnameTxt: UITextField!
    @IBOutlet weak var owner_lastnameTxt: UITextField!
    @IBOutlet weak var roleTxt: UILabel!
    
    // create alert controller
    func createAlert (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterCaregiverVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func register_click(_ sender: Any) {
        
        // if no text was entered
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || firstnameTxt.text!.isEmpty || lastnameTxt.text!.isEmpty || owner_usernameTxt.text!.isEmpty || owner_firstnameTxt.text!.isEmpty || owner_lastnameTxt.text!.isEmpty {
                  
                  // enforce red placeholders
                  usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                  
                  passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                  
                  firstnameTxt.attributedPlaceholder = NSAttributedString(string: "first name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                  
                  lastnameTxt.attributedPlaceholder = NSAttributedString(string: "last name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
                owner_firstnameTxt.attributedPlaceholder = NSAttributedString(string: "owner's first name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
                owner_lastnameTxt.attributedPlaceholder = NSAttributedString(string: "owner's last name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
                owner_usernameTxt.attributedPlaceholder = NSAttributedString(string: "owner's username", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            // if text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // ** create a new user in MySQL **
            
            // url to php file
            let url = URL(string: "http://smartersmarttv.com/tv_registerCG.php")!
            
            // request to the file
            var request = URLRequest(url: url)
            
            // method to pas data to this file
            request.httpMethod = "POST"
            
            // body to be appended to url
            let body = "username=\(usernameTxt.text!.lowercased())&password=\(passwordTxt.text!)&fullname=\(firstnameTxt.text!)%20\(lastnameTxt.text!)&role=\(roleTxt.text!)&owner_fullname=\(owner_firstnameTxt.text!)%20\(owner_lastnameTxt.text!)&owner_username=\(owner_usernameTxt.text!)"
            
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
                                
                                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                
                                // display a message saying success & go back to registration page
                                DispatchQueue.main.async(execute: {
                                        let message = "You have created an account"
                                        self.createAlert(title: "Success!", message: message)
                                        
                                    
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













































