//
//  UIView + Shadow.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 14/12/2021.
//

import UIKit


extension UIView{
    
    func set_Shadow_For_View(cornerRadius: CGFloat
                             ,shadowColor: CGColor
                             ,shadowRadius: CGFloat){
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 1
    }
    
}
