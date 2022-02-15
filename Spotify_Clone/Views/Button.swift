//
//  Button.swift
//  ContainerDemo
//
//  Created by Rauf Aliyev on 06.02.22.
//

import Foundation
import UIKit



class ReusableButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        tintColor = .label
        titleLabel?.font = .systemFont(ofSize: 40)
        CGRect(x: 0, y: 0, width: 600, height: 50)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
