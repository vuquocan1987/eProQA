//
//  InputChoiceTableViewCell.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/12/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit

class InputChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
