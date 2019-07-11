//
//  TwoTextFieldTableViewCell.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/11/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit

class TwoTextFieldsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
