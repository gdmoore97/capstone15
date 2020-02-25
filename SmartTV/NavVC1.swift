//
//  NavVC1.swift
//  SmartTV
//
//  Created by user160653 on 2/25/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class NavVC1: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // color of the title at the top of the nav controller
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        // color of the buttons in the nav controller
        self.navigationBar.tintColor = .white
        
        // color of background of the nav controller / nav bar
        self.navigationBar.barTintColor = .black
        
        
    }
    
    // white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    


}
