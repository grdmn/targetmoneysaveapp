//
//  CustomizableImageView.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
   

}
