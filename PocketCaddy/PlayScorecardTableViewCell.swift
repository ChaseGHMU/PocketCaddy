//
//  PlayScorecardTableViewCell.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/16/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PlayScorecardTableViewCell: UITableViewCell {

    @IBOutlet weak var holeNumberTitle: UILabel!
    @IBOutlet weak var scoresTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
