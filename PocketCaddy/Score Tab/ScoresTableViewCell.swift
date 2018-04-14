//
//  ScoresTableViewCell.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/4/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var scoreShot: UILabel!
    @IBOutlet weak var datePlayed: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
