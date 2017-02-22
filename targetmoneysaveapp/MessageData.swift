//
//  MessageData.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/23/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation

class MessageData{
    
    static let MSGTEXT_ID = "Text"
    static let MSGDATETIME_ID = "DateTime"
    
    private var _msgText:String!
    private var _msgDateTime:String!
    
    var MsgText:String {
        return _msgText
    }

    var MsgDateTime:String {
        return _msgDateTime
    }
    
    init(msgText:String, msgDateTime:String) {
        self._msgText = msgText
        self._msgDateTime = msgDateTime
    }
    
}
