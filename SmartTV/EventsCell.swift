//
//  EventsCell.swift
//  SmartTV
//
//  Created by user160653 on 3/4/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class EventsCell: UITableViewCell {
    
    // UI Objects
    @IBOutlet weak var eventnameTxt: UILabel!
    @IBOutlet weak var eventlocationTxt: UILabel!
    @IBOutlet weak var eventtimeTxt: UILabel!
    
    // first load func
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
