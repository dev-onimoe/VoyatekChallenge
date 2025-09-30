//
//  Extensions.swift
//  PaystackChallenge
//
//  Created by Masud Onikeku on 03/07/2024.
//

import Foundation

import Foundation
import UIKit

extension UIView {
    
    func constraint (equalToTop: NSLayoutYAxisAnchor? = nil,
                         equalToBottom: NSLayoutYAxisAnchor? = nil,
                         equalToLeft: NSLayoutXAxisAnchor? = nil,
                         equalToRight: NSLayoutXAxisAnchor? = nil,
                         paddingTop: CGFloat = 0,
                         paddingBottom: CGFloat = 0,
                         paddingLeft: CGFloat = 0,
                         paddingRight: CGFloat = 0,
                         width: CGFloat? = nil,
                         height: CGFloat? = nil
        ) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let equalToTop = equalToTop {
                
                topAnchor.constraint(equalTo: equalToTop, constant: paddingTop).isActive = true
            }
            
            if let equalTobottom = equalToBottom {
                
                bottomAnchor.constraint(equalTo: equalTobottom, constant: -paddingBottom).isActive = true
            }
            
            if let equalToLeft = equalToLeft {
                
                leadingAnchor.constraint(equalTo: equalToLeft, constant: paddingLeft).isActive = true
            }
            
            if let equalToRight = equalToRight {
                
                trailingAnchor.constraint(equalTo: equalToRight, constant: -paddingRight).isActive = true
            }
            
            if let width = width {
                
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
    func centre (centerX: NSLayoutXAxisAnchor? = nil, centreY: NSLayoutYAxisAnchor? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false

            if let centerx = centerX {
                
                centerXAnchor.constraint(equalTo: centerx).isActive = true
            }
            
            if let centery = centreY {
                
                centerYAnchor.constraint(equalTo: centery).isActive = true
            }
        }

    
}

extension UIColor {
    
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex

        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            hex         = hex.substring(from: index)
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension UIView {
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func showFromBottom(){
        frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: 0.4) {
            self.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        } completion: { (_) in}
    }
    
    func hideFromBottom(){
        UIView.animate(withDuration: 0.4) {
            self.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        } completion: { (_) in
            self.removeFromSuperview()
        }
    }
}

