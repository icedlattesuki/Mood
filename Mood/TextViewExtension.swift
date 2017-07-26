//
//  TextViewExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/26.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class TextViewExtension: UITextView{
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 5.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 5.0
    }
}
