//
//  EventsCellO.swift
//  SmartTV
//
//  Created by user160653 on 3/6/20.
//  Copyright © 2020 Gabriella Moore. All rights reserved.
//

import UIKit

class EventsCellO: UITableViewCell {

    @IBOutlet weak var eventnameTxt: UILabel!
    @IBOutlet weak var eventlocationTxt: UILabel!
    @IBOutlet weak var eventdateTxt: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
