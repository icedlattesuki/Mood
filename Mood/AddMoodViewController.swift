//
//  AddMoodViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material
import SCLAlertView

class AddMoodViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var moodControl: MoodControl!
    @IBOutlet weak var textField: TextViewExtension!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: Action
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.textField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if moodControl.moodScore == -1 {
            let alert = SCLAlertView()

            alert.showWarning("保存失败", subTitle: "需要选定一个心情~~~")
        } else {
            let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
            let alert = SCLAlertView(appearance: appearance)

            alert.addButton("Done", target: self, selector: #selector(AddMoodViewController.saveSuccess))
            
            let record = Record(moodScore: moodControl.moodScore, sentence: textField.text!)
            let result = record.save()
            
            if result.success {
                alert.showSuccess("保存成功", subTitle: "")
            } else {
                alert.showError("保存失败", subTitle: "")
            }
        }
    }
    
    //MARK: Methods
    
    @objc private func saveSuccess() {
        self.textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}
