//
//  SignUpViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var userNameTextField: TextFieldExtension!
    @IBOutlet weak var emailTextField: TextFieldExtension!
    @IBOutlet weak var password1TextField: TextFieldExtension!
    @IBOutlet weak var password2TextField: TextFieldExtension!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: ButtonExtension) {
        
        let userName = userNameTextField.text!
        let email = emailTextField.text!
        let password1 = password1TextField.text!
        let password2 = password2TextField.text!
        
        let alertController = UIAlertController(title: "注册失败", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        //判断是否有空项
        if userName == "" || email == "" || password1 == "" || password2 == "" {
            alertController.message = "各项均不能为空"
            present(alertController, animated: true)
            return
        }
        
        //判断两次密码是否一致
        if password1 != password2 {
            alertController.message = "两次输入的密码不一致"
            present(alertController, animated: true)
            return
        }
        
        //对用户名进行过滤(可扩展)
        for index in userName.characters.indices {
            if userName[index] == " " {
                alertController.message = "用户名只能由数字、字母、下划线以及中文字符组成"
                present(alertController, animated: true, completion: nil)
                return
            }
        }
        
        //对密码进行过滤
        for index in password1.characters.indices {
            if !((password1[index] >= "0" && password1[index] <= "9") || (password1[index] >= "a" && password1[index] <= "z") || (password1[index] >= "A" && password1[index] <= "Z")) {
                alertController.message = "密码只能由数字和字母组成"
                present(alertController, animated: true, completion: nil)
                return
            }
        }
        
        //注册
        let user = User(userName: userName, email: email, password: password1)
        let result = user.signUp()
        
        if result.success {
            alertController.title = "注册成功！验证邮件已发送✌️"
            alertController.message = "请前往邮箱\(email)验证邮件后即可登录Mood!"
            present(alertController, animated: true)
        } else {
            switch result.error {
            case .userNameDuplicate:
                alertController.message = "该用户名已经被注册"
            case .emailDuplicate:
                alertController.message = "该邮箱已经被注册"
            case .unvalidEmail:
                alertController.message = "无效的电子邮箱"
            case .unknownError:
                alertController.message = "未知的错误"
            default:
                break
            }
            present(alertController, animated: true)
        }
    }
}
