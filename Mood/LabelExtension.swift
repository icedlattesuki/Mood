//
//  LabelExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/26.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class LabelExtension: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.numberOfLines = 0
        self.lineBreakMode = .byTruncatingTail
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.numberOfLines = 0
        self.lineBreakMode = .byTruncatingTail
        self.sizeToFit()
    }
}
