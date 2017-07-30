//
//  SignInViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/23.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material
import LTMorphingLabel
import SCLAlertView

class SignInViewController: UIViewController, TextFieldDelegate, LTMorphingLabelDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var userNameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var moodLabel: LTMorphingLabel!

    //MARK: Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moodLabel.morphingEffect = .evaporate
        
        userNameTextField.placeholder = "User Name"
        passwordTextField.placeholder = "Password"
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    @IBAction func signIn(_ sender: ButtonExtension) {
        let userName = userNameTextField.text!
        let password = passwordTextField.text!
        
        let alert = SCLAlertView()
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        //判断用户名或密码是否为空
        if userName == "" || password == "" {
            alert.showError("登录失败", subTitle: "用户名或密码不能为空")
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
                alert.showError("登录失败", subTitle: "用户不存在")
            case .userNameAndPasswordMismatch:
                alert.showError("登录失败", subTitle: "用户名或密码错误")
            case .emailUnverified:
                alert.showError("登录失败", subTitle: "邮箱未验证")
            default:
                alert.showError("登录失败", subTitle: "未知错误")
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
