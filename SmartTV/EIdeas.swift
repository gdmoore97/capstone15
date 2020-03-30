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
        
        var clean_idea = ""
        if ideaname == "lunchdate" {
            clean_idea = "Lunch date with Friend"
        }
        else if ideaname == "dinnerdate" {
            clean_idea = "Dinner date with Friend"
        }
        else if ideaname == "swimming" {
            clean_idea = "Swimming Lesson"
        }
        else if ideaname == "golf" {
            clean_idea = "Golf Game"
        }
        else if ideaname == "tennis" {
            clean_idea = "Tennis Match"
        }
        else if ideaname == "basketball" {
            clean_idea = "Basketball Game"
        }
        else if ideaname == "cards" {
            clean_idea = "Card Game with Friends"
        }
        else if ideaname == "boatride" {
            clean_idea = "Boat Ride with Friends"
        }
        else if ideaname == "cruise" {
            clean_idea = "Cruise for vacation"
        }
        else {
            clean_idea = "Vacation with Family or Friends"
        }
        
        cell.eventIdeaTxt.text = clean_idea
        
        return cell
        
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

        loadIdeas()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            deleteEventIdea(indexPath)
        }
    }
    

    @objc func deleteEventIdea(_ indexPath: IndexPath) {
        
        let idea = ideas[indexPath.row]
        var ideaid = 1
        if let id = idea["id"] {
            ideaid = id as! Int
        }
        
        let url = URL(string: "http://smartersmarttv.com/tv_deleteeventidea.php")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = "id=\(ideaid)"
        request.httpBody = body.data(using: String.Encoding.utf8)
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async(execute: {
                
                if error == nil {
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error with parsing")
                            return
                        }
                        
                        let result = parseJSON["result"]
                        
                        if result != nil{
                            
                            self.ideas.remove(at: indexPath.row)
                            self.tableV.deleteRows(at: [indexPath], with: .automatic)
                            self.tableV.reloadData()
                            
                        } else {
                            
                            DispatchQueue.main.async(execute: {
                                let message = parseJSON["message"] as! String
                                  self.createAlert(title: "Error", message: message)
                                print("stop 1")
                            })
                            return
                        }
                        
                    } catch {
                        // add info here
                        
                        DispatchQueue.main.async(execute: {
                            self.ideas.remove(at: indexPath.row)
                            self.tableV.deleteRows(at: [indexPath], with: .automatic)
                            self.tableV.reloadData()
                            
                        })
                        return
                    }
                } else {
                    
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        self.createAlert(title: "Error", message: message)
                        print("stop 3")
                    })
                    return
                }
            })
            } .resume()
        
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







































