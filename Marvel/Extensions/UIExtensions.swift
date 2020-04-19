//
//  UIExtensions.swift
//  Marvel
//
//  Created by Toni De Gea on 19/04/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func configureShadow(color: UIColor = UIColor.lightGray,
                         opacity: Float = 0.5,
                         radius: CGFloat = 5.0,
                         offset: CGSize = CGSize(width: 1.0, height: 5.0)) {
        
        self.layer.shadowColor = color.cgColor // el color de la sombra
        self.layer.shadowOffset = offset // desde donde empieza la sombra
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
