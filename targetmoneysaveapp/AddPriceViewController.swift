//
//  AddPriceViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AddPriceViewController: UIViewController {
    
    @IBOutlet weak var inputPriceTxt:UITextField!
    

//    var firDataSnapshotArray:[FIRDataSnapshot]! = [FIRDataSnapshot]()
//    var databaseRef:FIRDatabaseReference!
//    private var _databaseHandle:FIRDatabaseHandle! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
    }
    

    
    @IBAction func btnSendPriceTarget(_ sender: Any) {
        
//        if((inputPriceTxt.text?.characters.count)! > 0) {
//            let priceData = TargetData(priceText: inputPriceTxt.text!, datetimeText:Const().CurrentDateTimeToStr())
//            sendPrice(priceData: priceData, datetimeData: priceData)
//            inputPriceTxt.text = ""
//        }
        
        if (inputPriceTxt.text!.characters.count < 0) {
            Const().showAlert(title: "Error", message: "กรุณากรอกจำนวนเงิน", viewController: self)
            return
        }
        else{
            inputPriceTxt.backgroundColor = UIColor.white
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let usersReference = ref.child("Target").child((FIRAuth.auth()?.currentUser?.uid)!)
        
        let addPriceData = ["Price": self.inputPriceTxt.text!, "Username":FIRAuth.auth()?.currentUser?.email as Any]
        usersReference.setValue(addPriceData)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   
}
