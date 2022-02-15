//
//  Factorie.swift
//  ContainerDemo
//
//  Created by Rauf Aliyev on 13.02.22.
//

import Foundation
import UIKit


func createStackView () -> UIStackView {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8.0
    return stack
}
