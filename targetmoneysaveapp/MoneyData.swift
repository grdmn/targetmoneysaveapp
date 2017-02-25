//
//  MoneyData.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation

class MoneyData{
    
    static let TARGETTEXT_ID = "TargetText"
    
    private var _moneyText:String!
    
    var MoneyText:String{
        return _moneyText
    }
    
    init(moneyText:String) {
        self._moneyText = moneyText
    }
    
}
