//
//  HistoryMoodTableViewCell.swift
//  Mood
//
//  Created by Hys on 2017/7/25.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class HistoryMoodTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    
    //MARK: Override functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
