//
//  MoneyData.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation

class MoneyData{
    
    static let MONEYTEXT_ID = "MoneyText"
    static let NAMETARGET_ID = "NameTargetText"
    static let PRICETEXT_ID = "PriceText"
    
    
    private var _moneyText:String!
    private var _nameTargetText:String!
    private var _priceText:String!
    
    var MoneyText:String{
        return _moneyText
    }
    
    var NameTargetText:String{
        return _nameTargetText
    }
    
    init(moneyText:String) {
        self._moneyText = moneyText
    }
    
    init(nameTargetText:String) {
        self._nameTargetText = nameTargetText
    }
    
}
