//
//  PlaySearchTableViewCell.swift
//  PocketCaddy
//
//  Created by Chase Allen on 3/2/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import UIKit

class PlaySearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
