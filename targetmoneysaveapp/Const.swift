//
//  Const.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/23/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation
import UIKit

class Const {
    
    func showAlert(title:String, message:String, viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(resultAlert)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func CurrentDateTimeToStr() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: currentDate)
    }
    
//    func CalculateTotal () -> String {

    
    
    
}
