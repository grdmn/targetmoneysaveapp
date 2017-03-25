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
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        databaseInit()
//    }
    
//    func databaseInit(){
//        databaseRef = FIRDatabase.database().reference()
//        
//        _databaseHandle = self.databaseRef.child("AddTarget").observe(.childAdded, with: { (firebaseSnapshot) in
//            self.firDataSnapshotArray.append(firebaseSnapshot)
//            
//            //let indexPathOfLastRow = IndexPath(row: self.firDataSnapshotArray.count-1, section: 0)
//            //self.tableView.insertRows(at: [indexPathOfLastRow], with: .automatic)
//            
//            
//        })
//    }
    
//    deinit {
//        
//    }
    
    
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
        let usersReference = ref.child("AddTarget").childByAutoId()
        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)  //Unique
        
        let addPriceData = ["Price": self.inputPriceTxt.text!, "Username":FIRAuth.auth()?.currentUser?.email as Any ,"Time": timestamp] as [String : Any]
        
        
        
        
        usersReference.setValue(addPriceData)
        
        
    }
    
//    func sendPrice(priceData: TargetData, datetimeData: TargetData) {
//        
//        //        var dataValue = [String: String]()
//        //        dataValue[MoneyData.NAMETARGET_ID] = nameTargetData.nameTargetText
//        
//        let dataValue: Dictionary<String, AnyObject> =
//            [
//                TargetData.PRICETEXT_ID: priceData.PriceText as AnyObject,
//               TargetData.DATETIMETEXT_ID: priceData.DateTimeText as AnyObject
//        ]
//        self.databaseRef.child("AddTarget").childByAutoId().setValue(dataValue)
//        //self.databaseRef.child("AddTarget").setValue(dataValue)
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   
}
