//
//  TargetData.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation

class TargetData {
    
    static let NAMETARGET_ID = "NameTargetText"
    
    private var _nameTargetText:String!
    
    var NameTargetText:String{
        return _nameTargetText
    }
    
    init(nameTargetText:String) {
        self._nameTargetText = nameTargetText
    }
    
    static let PRICETEXT_ID = "PriceText"
    
    private var _priceText:String!
    
    var PriceText:String{
        return _priceText
    }
    
    init(priceText:String, datetimeText:String) {
        self._priceText = priceText
        self._datetimeText = datetimeText
    }
    
    static let DATETIMETEXT_ID = "DateTime"
    
    private var _datetimeText:String!
    
    var DateTimeText:String{
        return _datetimeText
    }
    

    
    
    
    
}
