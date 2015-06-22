//
//  MeMeTableViewCell.swift
//  Experiment
//
//  Created by Steven Hertz on 6/17/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit

class MeMeTableViewCell: UITableViewCell {

  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var memimg: UIImageView!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
