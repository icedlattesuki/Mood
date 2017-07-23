//
//  ButtonExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class ButtonExtension: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 17
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 17
    }
}
