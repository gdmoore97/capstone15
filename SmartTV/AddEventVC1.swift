//
//  AddEventVC1.swift
//  SmartTV
//
//  Created by user160653 on 2/25/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class AddEventVC1: UIViewController {

    
    @IBOutlet weak var fullnameText: UITextField!
    @IBOutlet weak var eventnameText: UITextField!
    @IBOutlet weak var eventlocationText: UITextField!
    @IBOutlet weak var eventdateText: UITextField!
    @IBOutlet weak var eventdateDB: UILabel!
    
    var datePicker : UIDatePicker?
    
    @IBAction func add_event(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        
        // sets up the labl for UI view
        datePicker?.addTarget(self, action: #selector(AddEventVC1.dateChanged(datePicker:)), for: .valueChanged)
        
        // sets up the label for the db
        datePicker?.addTarget(self, action: #selector(AddEventVC1.dateChangedDB(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddEventVC1.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        eventdateText.inputView = datePicker

    }
    
      @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
          view.endEditing(true)
      }
      
      // function to format the label with human readable date label
      @objc func dateChanged(datePicker : UIDatePicker) {
          
          let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .full
          dateFormatter.timeStyle = .short
          eventdateText.text = dateFormatter.string(from: datePicker.date)
          
      }
      
      // function to format the label with db readable date label
      @objc func dateChangedDB(datePicker : UIDatePicker) {
          
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
          eventdateDB.text = dateFormatter.string(from: datePicker.date)
          
      }
    
    



}
