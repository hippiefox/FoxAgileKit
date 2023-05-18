//
//  ViewExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit
public extension UIView{
    var fak_reuseId: String{self.classForCoder.description()}
    
    func fak_border(width: CGFloat,color: UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func fak_radius(_ radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func fak_borderRadius(width: CGFloat,color: UIColor,radius: CGFloat){
        self.fak_radius(radius)
        self.fak_border(width: width, color: color)
    }
}
