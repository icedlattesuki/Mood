//
//  Record.swift
//  Mood
//
//  Created by Hys on 2017/7/24.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import LeanCloud

//记录类
class Record {
    
    //MARK: Properties
    
    var moodScore: Int
    var sentence: String
    
    //MARK: Initialization
    
    init(moodScore: Int, sentence: String) {
        self.moodScore = moodScore
        self.sentence = sentence
    }
    
    //MARK: Methods
    
    func save() -> Result {
        var result = Result()
        if let currentUser = LCUser.current {
            let email = currentUser.email
            let moodRecords = LCObject(className: "MoodRecords")
            
            moodRecords.set("email", value: email)
            moodRecords.set("moodScore", value: moodScore)
            moodRecords.set("sentence", value: sentence)
            
            let LCRsult = moodRecords.save()
            
            if LCRsult.isSuccess {
                result.success = true
            }
        }
        return result
    }
}
