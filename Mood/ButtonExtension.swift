//
//  ButtonExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

@IBDesignable class ButtonExtension: UIButton {
    @IBInspectable var color: UIColor = UIColor(red: ThemeColor.red, green: ThemeColor.green, blue: ThemeColor.blue, alpha: 1) {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        update()
    }
    
    //MARK: Methods
    
    func update() {
        self.backgroundColor = UIColor.white
        self.borderWidth = 1.5
        self.borderColor = color
        self.layer.cornerRadius = 5
        self.setTitleColor(color, for: .normal)
    }
}
