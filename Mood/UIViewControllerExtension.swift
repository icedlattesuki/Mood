//
//  UIViewControllerExtension.swift
//  Mood
//
//  Created by Hys on 2017/7/29.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: .hideKeyboard)
        
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
}

extension Selector {
    static let hideKeyboard = #selector(UIViewController.hideKeyboard)
}
