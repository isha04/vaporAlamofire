//
//  taskTableViewCell.swift
//  vaporAlamofire
//
//  Created by Isha on 9/14/18.
//  Copyright © 2018 Isha. All rights reserved.
//

import UIKit

class taskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var completionStatus: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var aTask: tasky? {
        didSet {
            guard let task = aTask else {return}
            id.text = task.id
            if task.completed == "false" {
                completionStatus.text = "Incomplete"
            } else if task.completed == "true" {
                completionStatus.text = "Complete"
            }
            title.text = task.title
        }
    }

    
    

}
