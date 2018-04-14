//
//  PracticeClubViewCell.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/11/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PracticeClubViewCell: UITableViewCell {

    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubTitle: UILabel!
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var avgDistanceTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
