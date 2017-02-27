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
    private var _datetimeText:String! = ""
    private var _priKey:String!
    
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
    
    init(priKey:String, data:Dictionary<String, AnyObject>) {
        self._priKey = priKey
        
        if let MoneyText = data[MoneyData.MONEYTEXT_ID] as? String
        {
            self._moneyText = MoneyText
        }
        if let DateTimeText = data[MoneyData.DATETIMETEXT_ID] as? String
        {
            self._datetimeText = DateTimeText
        }
    }

}
