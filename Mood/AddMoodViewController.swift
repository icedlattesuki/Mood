//
//  AddMoodViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class AddMoodViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var moodControl: MoodControl!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Action
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if moodControl.moodScore == -1 {
            let alertController = UIAlertController(title:"保存失败!", message:"需要选定一个心情～", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "知道啦", style: .cancel)
            
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title:"", message:"", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "知道啦", style: .cancel) { action in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(alertAction)
            
            let record = Record(moodScore: moodControl.moodScore, sentence: textField.text!)
            let result = record.save()
            
            if result.success {
                alertController.title = "保存成功!"
            } else {
                alertController.title = "保存失败!"
            }
            alertController.message = ""
            present(alertController, animated: true, completion: nil)
        }
    }
}
