//
//  TextFieldExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class TextFieldExtension: UITextField, UITextFieldDelegate{
    
    //MARK: Properties
    
    var tmpPlaceholder = ""
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.borderStyle = .roundedRect
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.borderStyle = .roundedRect
        self.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.textAlignment = .left
        if self.placeholder != nil {
            tmpPlaceholder = self.placeholder!
        }
        self.placeholder = nil
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.text == nil || self.text == "" {
            self.placeholder = tmpPlaceholder
            self.textAlignment = .center
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
