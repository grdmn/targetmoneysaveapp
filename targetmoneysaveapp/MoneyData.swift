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
    static let DATETIMETEXT_ID = "DateTime"
    
    
    private var _moneyText:String!
    private var _datetimeText:String!
    
    var MoneyText:String{
        return _moneyText
    }
    
    var DateTimeText:String{
        return _datetimeText
    }
    
    init(moneyText:String, datetimeText:String) {
        self._moneyText = moneyText
        self._datetimeText = datetimeText
    }
}
