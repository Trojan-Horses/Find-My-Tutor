//
//  ProfileTableViewCell.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 4/13/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tutorLabel: UILabel!

    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
