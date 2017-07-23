//
//  SignInViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/23.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var userNameTextField: TextFieldExtension!
    @IBOutlet weak var passwordTextField: TextFieldExtension!

    //MARK: Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    @IBAction func signIn(_ sender: ButtonExtension) {
        let userName = userNameTextField.text!
        let password = passwordTextField.text!
        
        let alertController = UIAlertController(title: "登录失败", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "知道啦", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        
        //判断用户名或密码是否为空
        if userName == "" || password == "" {
            alertController.message = "用户名或密码不能为空"
            present(alertController, animated: true)
            return
        }
        
        //登录
        let user = User(userName: userName, password: password)
        let result = user.signIn()
        
        if result.success {
            performSegue(withIdentifier: "signIn", sender: self)
            present(MainTabBarController(), animated: true)
        } else {
            switch result.error {
            case .userNotExist:
                alertController.message = "用户不存在"
            case .userNameAndPasswordMismatch:
                alertController.message = "密码错误"
            case .emailUnverified:
                alertController.message = "邮箱未验证"
            default:
                alertController.message = "未知错误"
            }
            present(alertController, animated: true)
        }
    }
}
