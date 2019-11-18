//
//  StudentCell.swift
//  DogukanKarayilanoglu_755495_gpaApp
//
//  Created by DKU on 15.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {
    

    
    @IBOutlet weak var studentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
