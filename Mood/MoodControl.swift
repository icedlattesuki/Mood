//
//  MoodControl.swift
//  Mood
//
//  Created by Hys on 2017/7/20.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class MoodControl: UIStackView {
    
    //MARK: Properties
    
    var moodScore = -1 {
        didSet {
            updateButtonState()
        }
    }
    var buttons = [UIButton]()
    let imageNames = ["开心", "愉快", "一般", "难过", "悲伤", "想哭"]
    let selectedImage = "选中"
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpButtons()
    }
    
    //MARK: Private Methods
    
    private func setUpButtons() {
        
        //清除已经存在的button
        for index in 0..<buttons.count {
            removeArrangedSubview(buttons[index])
        }
        
        buttons.removeAll()
        
        //生成button
        for index in 0..<6 {
            let button = UIButton()
            
            if let image = UIImage(named: imageNames[index], in: nil, compatibleWith: nil) {
                button.setImage(image, for: .normal)
            }
            
            if let imageForSelected = UIImage(named: selectedImage, in: nil, compatibleWith: nil) {
                button.setImage(imageForSelected, for: .selected)
            }
            
            button.addTarget(self, action: .buttonPressed, for: .touchUpInside)
            addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    private func updateButtonState() {
        for index in 0..<6 {
            buttons[index].isSelected = false
        }
        
        if moodScore != -1 {
            buttons[5 - moodScore].isSelected = true
        }
    }
    
    //MARK: Action
    
    func buttonPressed(_ sender: UIButton) {
        guard let index = buttons.index(of: sender) else {
            fatalError("invaild buttong pressed!")
        }
        
        let score = 5 - index
        
        if score == moodScore {
            moodScore = -1
        } else {
            moodScore = score
        }
    }
}

private extension Selector {
    static let buttonPressed = #selector(MoodControl.buttonPressed(_:))
}
