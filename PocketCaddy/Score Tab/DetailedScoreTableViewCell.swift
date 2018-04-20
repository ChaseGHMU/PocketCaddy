//
//  DetailedScoreTableViewCell.swift
//  PocketCaddy
//
//  Created by Megan Cochran on 4/19/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class DetailedScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var hole: UILabel!
    @IBOutlet weak var holeScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
