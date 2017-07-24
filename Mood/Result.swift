//
//  Result.swift
//  Mood
//
//  Created by Hys on 2017/7/24.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit


//各类错误
enum Errors {
    
    //注册错误
    case userNameDuplicate
    case emailDuplicate
    case unvalidEmail
    
    //登录错误
    case userNotExist
    case userNameAndPasswordMismatch
    case emailUnverified
    
    //未知错误
    case unknownError
}

//定义Result储存各操作结果信息
struct Result {
    var success = false
    var error: Errors = .unknownError
}
