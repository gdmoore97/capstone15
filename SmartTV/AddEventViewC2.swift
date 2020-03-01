//
//  AddEventViewC2.swift
//  SmartTV
//
//  Created by user160653 on 3/1/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class AddEventViewC2: UIViewController {
    
    
    @IBOutlet weak var eventnameTxt: UITextField!
    @IBOutlet weak var eventlocationTxt: UITextField!
    @IBOutlet weak var eventdateTxt: UITextField!
    @IBOutlet weak var eventDB: UILabel!
    
    var datePicker : UIDatePicker?
    
    
    @IBAction func add_event_click(_ sender: Any) {
        
        // if no text was entered
        if eventnameTxt.text!.isEmpty || eventnameTxt.text!.isEmpty || eventdateTxt.text!.isEmpty {
            
            // enforce red placeholders
            eventnameTxt.attributedPlaceholder = NSAttributedString(string: "event name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            eventlocationTxt.attributedPlaceholder = NSAttributedString(string: "event location", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
            eventdateTxt.attributedPlaceholder = NSAttributedString(string: "event date & time", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
        } else {
            
            // user login
            
            // obtain the user's username
            var u = ""
            if let username = user!["username"] {
                u = username as! String
            }
            
            // obtain the user's full name
            var name = ""
            if let fullname = user!["fullname"] {
                name = fullname as! String
            }
            
            // remove keyboard
            self.view.endEditing(true)
            
            // *** create an event in MySQL ***
            
            // url to php file
            let url = URL(string: "http://smartersmarttv.com/tv_events.php")!
            
            // request to the file
            var request = URLRequest(url: url)
            
            // method to pass the data to the file
            request.httpMethod = "POST"
            
            // body to be appended to url
            let body = "eventname=\(eventnameTxt.text!)&eventlocation=\(eventlocationTxt.text!)&eventdate=\(eventDB.text!)&fullname=\(name)&creator_username=\(u)"
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            // process the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    DispatchQueue.main.async(execute: {
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            let id = parseJSON["id"]
                            
                            if id != nil {
                                //print(name as Any)
                                DispatchQueue.main.async(execute: {
                                    let message = "You have added an event"
                                    self.createAlert(title: "Success!", message: message)
                                })
                            } else {
                                DispatchQueue.main.async(execute: {
                                    let message = parseJSON["message"] as! String
                                    self.createAlert(title: "Error", message: message)
                                })
                                return
                            }
                        } catch {
                            DispatchQueue.main.async(execute: {
                                let message = "\(error)"
                                self.createAlert(title: "Error", message: message)
                            })
                            return
                            
                        }
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        self.createAlert(title: "Error", message: message)
                    })
                    return
                }
                } .resume()
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

         datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
               
        // sets up the labl for UI view
        datePicker?.addTarget(self, action: #selector(AddEventViewC2.dateChanged(datePicker:)), for: .valueChanged)
               
               // sets up the label for the db
        datePicker?.addTarget(self, action: #selector(AddEventViewC2.dateChangedDB(datePicker:)), for: .valueChanged)
               
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddEventViewC2.viewTapped(gestureRecognizer:)))
               
        view.addGestureRecognizer(tapGesture)
               
        eventdateTxt.inputView = datePicker
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
          view.endEditing(true)
      }
      
      // function to format the label with human readable date label
      @objc func dateChanged(datePicker : UIDatePicker) {
          
          let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .full
          dateFormatter.timeStyle = .short
          eventdateTxt.text = dateFormatter.string(from: datePicker.date)
          
      }
      
      // function to format the label with db readable date label
      @objc func dateChangedDB(datePicker : UIDatePicker) {
          
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
          eventDB.text = dateFormatter.string(from: datePicker.date)
          
      }
    
    // create alert controller
    func createAlert (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
  

}
