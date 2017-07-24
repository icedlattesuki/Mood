//
//  User.swift
//  Mood
//
//  Created by Hys on 2017/7/23.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import LeanCloud

//用户类
class User {
    
    //MARK: Properties
    
    var userName: String!
    var email: String!
    var password: String!
    
    //MARK: Initialization
    
    init(userName: String, email: String, password: String) {
        self.userName = userName
        self.email = email
        self.password = password
    }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    //MARK: Methods
    
    func signUp() -> Result{
        //调用LeanCloudAPI进行注册
        let user = LCUser()
        
        user.username = LCString(userName)
        user.email = LCString(email)
        user.password = LCString(password)
        
        let LCResult = user.signUp()
        var result = Result()
        
        //对注册结果进行处理，重新包装后返回
        if LCResult.isSuccess {
            result.success = true
        } else {
            result.success = false
            switch LCResult.error!.code {
            case 202:
                result.error = .userNameDuplicate
            case 203:
                result.error = .emailDuplicate
            case 125:
                result.error = .unvalidEmail
            default:
                result.success = true
            }
        }
        
        return result
    }
    
    func signIn() -> Result {
        //调用LeanCloudAPI进行登录
        let LCResult = LCUser.logIn(username: userName, password: password)
        var result = Result()
        
        //对登录结果重新包装后返回
        if LCResult.isSuccess {
            result.success = true
        } else {
            result.success = false
            switch LCResult.error!.code {
            case 211:
                result.error = .userNotExist
            case 210:
                result.error = .userNameAndPasswordMismatch
            case 216:
                result.error = .emailUnverified
            default:
                break
            }
        }
        
        return result
    }
}
