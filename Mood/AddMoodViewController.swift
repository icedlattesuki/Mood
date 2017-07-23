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
            let alertController = UIAlertController(title:"发现错误!", message:"需要选定一个心情～", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "知道啦", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            
        }
    }
}
