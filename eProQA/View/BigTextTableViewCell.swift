//
//  BigTextTableViewCell.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/12/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit

class BigTextTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var textView: UITextView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
