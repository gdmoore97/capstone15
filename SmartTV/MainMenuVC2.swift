//
//  MainMenuVC2.swift
//  SmartTV
//
//  Created by user160653 on 3/1/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class MainMenuVC2: UIViewController {
    
    
    @IBAction func logout_click(_ sender: Any) {
        
        // remove saved user info
        UserDefaults.standard.removeObject(forKey: "parseJSON")
        UserDefaults.standard.synchronize()
        
        // go to login page
        let loginvc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.present(loginvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    


}
