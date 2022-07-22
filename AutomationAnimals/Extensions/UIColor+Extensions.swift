//
//  UIColor+Extensions.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import UIKit

extension UIColor {
    static func random(withAlpha alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: CGFloat.random(in: 0.7...1), green: CGFloat.random(in: 0.7...1), blue: CGFloat.random(in: 0.7...1), alpha: alpha)
    }
}
