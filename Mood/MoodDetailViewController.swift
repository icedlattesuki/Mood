//
//  MoodDetailViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/26.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class MoodDetailViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var sentenceLabel: UILabel!
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sentenceLabel.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
