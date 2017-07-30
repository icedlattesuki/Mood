//
//  SignUpViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/21.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material
import LTMorphingLabel
import SCLAlertView

class SignUpViewController: UIViewController, TextFieldDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var userNameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var password1TextField: TextField!
    @IBOutlet weak var password2TextField: TextField!
    @IBOutlet weak var moodLabel: LTMorphingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moodLabel.morphingEffect = .evaporate
        
        userNameTextField.placeholder = "User Name"
        emailTextField.placeholder = "E-Mail"
        password1TextField.placeholder = "Password"
        password2TextField.placeholder = "Password Again"
        userNameTextField.delegate = self
        emailTextField.delegate = self
        password1TextField.delegate = self
        password2TextField.delegate = self
        
        hideKeyboardWhenTappedAround()
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
        
        let alert = SCLAlertView()
        
        let alertController = UIAlertController(title: "注册失败", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        //判断是否有空项
        if userName == "" || email == "" || password1 == "" || password2 == "" {
            alert.showWarning("注册失败", subTitle: "各项均不能为空")
            return
        }
        
        //判断两次密码是否一致
        if password1 != password2 {
            alert.showWarning("注册失败", subTitle: "两次输入密码不一致")
            return
        }
        
        //对用户名进行过滤(可扩展)
        for index in userName.characters.indices {
            if userName[index] == " " {
                alert.showWarning("注册失败", subTitle: "用户名只能由数字、字母、下划线以及中文字符组成")
                return
            }
        }
        
        //对密码进行过滤
        for index in password1.characters.indices {
            if !((password1[index] >= "0" && password1[index] <= "9") || (password1[index] >= "a" && password1[index] <= "z") || (password1[index] >= "A" && password1[index] <= "Z")) {
                alert.showWarning("注册失败", subTitle: "密码只能由数字和字母组成")
                return
            }
        }
        
        //注册
        let user = User(userName: userName, email: email, password: password1)
        let result = user.signUp()
        
        if result.success {
            alert.showSuccess("注册成功", subTitle: "请前往邮箱\(email)验证邮件后即可登录Mood!")
        } else {
            switch result.error {
            case .userNameDuplicate:
                alert.showWarning("注册失败", subTitle: "该用户名已经被注册")
            case .emailDuplicate:
                alert.showWarning("注册失败", subTitle: "该邮箱已被注册")
            case .unvalidEmail:
                alert.showWarning("注册失败", subTitle: "无效的电子邮箱")
            case .unknownError:
                alert.showWarning("注册失败", subTitle: "未知错误")
            default:
                break
            }
        }
    }
    
    //MARK: TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if moodLabel.text == "Mood" {
            moodLabel.text = "M  o  o  d"
        } else {
            moodLabel.text = "Mood"
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
