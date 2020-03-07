//
//  EventsVCO.swift
//  SmartTV
//
//  Created by user160653 on 3/6/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class EventsVCO: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    // UI objects
    @IBOutlet weak var tableV: UITableView!
    var events = [AnyObject]()
    
      
      // create alert controller
       func createAlert (title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
               alert.dismiss(animated: true, completion: nil)
           }))
           
           self.present(alert, animated: true, completion: nil)
       }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellO", for: indexPath) as! EventsCellO
        
        // shortcuts
        let event = events[indexPath.row]
        let eventname = event["eventname"] as? String
        let eventlocation = event["eventlocation"] as? String
        let eventdate = event["eventdate"] as? String
        
         // @objc func dateChanged(datePicker : UIDatePicker) {
                
              //  let dateFormatter = DateFormatter()
             //   dateFormatter.dateStyle = .full
              //  dateFormatter.timeStyle = .short
            //    eventdateText.text = dateFormatter.string(from: datePicker.date)
                
           // }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = dateFormatter.date(from: eventdate!)!
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: date)
        
        
        // assigning shortcuts to ui object
        cell.eventnameTxt.text = eventname
        cell.eventlocationTxt.text = eventlocation
        cell.eventdateTxt.text = dateString
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadEvents()
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
         // press delete button from the swiped cell
               if editingStyle == .delete {
                   
                   // send delete php request
                   //deleteEvent(indexPath)
               }
    }
    
     // display events in the tableview
       @objc func loadEvents(){
           
           // shortcut to username
           let username = user!["username"] as! String
            print(username)
           //let owner = user!["owner_fullname"] as! String
           
           //opener.text = "Events you created for \(owner)"
           
           // accessing php file via url path
           let url = URL(string: "http://smartersmarttv.com/tv_selectevents.php")!
           
           // declare request to proceed php file
           var request = URLRequest(url: url)
           
           // declare method of passing info to php file
           request.httpMethod = "POST"
           
           // pass info to php file
           let body = "username=\(username)"
           request.httpBody = body.data(using: String.Encoding.utf8)
           
           // launch session
           URLSession.shared.dataTask(with: request) { data, response, error in
               
               DispatchQueue.main.async(execute: {
                   
                   if error == nil {
                       
                       do {
                           
                           // get content of $returnArray variable
                           let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                           
                           // clean up
                           self.events.removeAll(keepingCapacity: false)
                           self.tableV.reloadData()
                           
                           guard let parseJSON = json else {
                               print("Error while parsing")
                               return
                           }
                           
                           // declare new events to store in the parseJSON
                           guard let ets = parseJSON["events"] as? [AnyObject]
                               else {
                                   print("Error while parsing")
                                   return
                           }
                           
                          self.events = ets
                           
                           // reload tableV to show back info
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





























