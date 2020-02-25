//
//  LoginVC.swift
//  SmartTV
//
//  Created by user160653 on 2/17/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // UI objects
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // create alert controller
    func createAlert (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // clicked login button
    @IBAction func login_click(_ sender: Any) {
        
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // red placeholders
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
    } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // shortcuts
            let username = usernameTxt.text!.lowercased()
            let password = passwordTxt.text!
            
            //send request to mysql db
            // url to access our php file
            let url = URL(string: "http://smartersmarttv.com/tv_login.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data
            request.httpMethod = "POST"
            
            // body appended to the url
            let body = "username=\(username)&password=\(password)"
            
            // append body to our request that will be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else{
                            print("Error while parsing")
                            return
                        }
                        
                        let id = parseJSON["id"] as? String
                        let role = parseJSON["role"] as? String
                        
                        if id != nil {
                            
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                //print(user)
                                                    
                            // go to tabbar / home page
                            DispatchQueue.main.async(execute: {
                                //print(role as Any)
                                
                                // if the user is a cargiver, go to NavBar1
                                if role == "Caregiver" {
                                    // login function
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let nBar = storyboard.instantiateViewController(withIdentifier: "navBar")
                                    self.present(nBar, animated: true, completion: nil)
                                }
                                
                                else if role == "Owner" {
                                    // do the same as above but with a different NavBar
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let nBar2 = storyboard.instantiateViewController(withIdentifier: "navBar2")
                                    self.present(nBar2, animated: true, completion: nil)
                                    
                                }
                                
                                else {
                                    // throw an alert error
                                }
                            
                            })
                            
                            
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
                    
                } else {
                    
                    //get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        self.createAlert(title: "Error", message: message)
                    })
                    return
                }
                
                } .resume()
            
            
            
            
            
            
            
            
            
    }
    


}
    
    
}































