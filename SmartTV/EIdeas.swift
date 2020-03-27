//
//  EIdeas.swift
//  SmartTV
//
//  Created by user160653 on 3/27/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class EIdeas: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var opener: UILabel!
    @IBOutlet weak var tableV: UITableView!
    var ideas = [AnyObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdeaCell", for: indexPath) as! EICell
        
        let idea = ideas[indexPath.row]
        let ideaname = idea["idea"] as? String
        
        cell.eventIdeaTxt.text = ideaname
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadIdeas()
    }
    

    @objc func loadIdeas(){
        
        let username = user!["username"] as! String
        let owner = user!["owner_fullname"] as! String
        print(username)
        
        opener.text = "Event ideas for \(owner)"
        
        let url = URL(string: "http://smartersmarttv.com/tv_selectideas.php")!
        
        // declare request to proceed php file
        var request = URLRequest(url: url)
        
        // declare method of passing info to php file
        request.httpMethod = "POST"
        
        let body = "owner_username=\(username)"
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async(execute: {
                
                if error == nil {
                    
                    do {
                        
                        let json = try
                            JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        self.ideas.removeAll(keepingCapacity: false)
                        self.tableV.reloadData()
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            return
                        }
                        
                        guard let ets = parseJSON["ideas"] as? [AnyObject]
                            else {
                                print("Error while parsing")
                                return
                        }
                        
                        self.ideas = ets
                        
                        self.tableV.reloadData()
                        
                    } catch {
                        print("Caught an error \(error)")
                    }
                    
                } else {
                    print("Caught an error \(String(describing: error))")
                }
                
                
            })
            
            } .resume()
    }

}







































