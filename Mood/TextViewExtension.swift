//
//  TextViewExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/26.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material

class TextViewExtension: UITextView{
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
 
        let color = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        self.borderColor = color
        self.borderWidth = 0.5
        self.cornerRadius = 5
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let color = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        self.borderColor = color
        self.borderWidth = 0.5
        self.cornerRadius = 5
        self.backgroundColor = color
    }
}
