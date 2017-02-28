//
//  ShowAllTargetViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class ShowAllTargetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var TargetDataArray = [TargetData]()
    
//    var firDataSnapshotArray:[FIRDataSnapshot]! = [FIRDataSnapshot]()
    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("AddTarget").observe(.value, with: { (snapshot : FIRDataSnapshot) in
            
        //    var money = [TargetData]()
            
        //    self.moneyTotalLbl.text = (snapshot.value as AnyObject).description
            
        })
        
        //        let user = FIRAuth.auth()?.currentUser
        //        var newData = false
        //        databaseRef.child("AddTarget/PriceText")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        databaseInit()
    }
    
    

    
    func databaseInit(){
        databaseRef = FIRDatabase.database().reference()
        
        _databaseHandle = self.databaseRef.child("AddTarget").observe(.value, with: {
            (firebaseSnapshot) in
            
            self.TargetDataArray = []
            
            if let snapshot = firebaseSnapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let snapValue = snap.value as? Dictionary<String, AnyObject>
                    {
                        let key = snap.key
                        let moneyData = TargetData(priKey: key, data: snapValue)
                        self.TargetDataArray.append(moneyData)
                    }
                    
                }
            }
            self.tableView.reloadData()
        })

    
    }



    deinit {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TargetDataArray.count
//        return firDataSnapshotArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let targetData = TargetDataArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTargetViewCell") as? ShowTargetAllTableViewCell {
            
            cell.setValue(targetData: targetData, priceData: targetData, datetimeData: targetData)
            
            return cell
        }
        else{
            
            let cell = ShowTargetAllTableViewCell()
            cell.setValue(targetData: targetData, priceData: targetData, datetimeData: targetData)
            
            return cell
            
            
        }

        
//        
//        let firDataSnapshot = self.firDataSnapshotArray[indexPath.row]
//        let snapShotValue = firDataSnapshot.value as! Dictionary<String, AnyObject>
//        
//        var strText = ""
//        
//        if let tempstrText = snapShotValue[TargetData.NAMETARGET_ID] as! String! {
//            strText = tempstrText
//        }
//        
//        var strPrice = ""
//        
//        if let tempsstrPrice = snapShotValue[TargetData.PRICETEXT_ID] as! String! {
//            strPrice = tempsstrPrice
//        }
//        
//        var strDateTime = ""
//        if let tempstrDateTime = snapShotValue[MoneyData.DATETIMETEXT_ID] as! String! {
//            strDateTime = tempstrDateTime
//        }
//
//        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTargetViewCell") as? ShowTargetAllTableViewCell {
//            
//            if (strText != "" && strPrice != "" ){
//                
//                let
//                let targetData = TargetData(nameTargetText: strText)
//                let targetDataprice = TargetData(priceText: strPrice, datetimeText: strDateTime)
//                let targetDataprice = TargetData(prikey: , data: snapShotValue)
//                
//                
//                cell.setValue(targetData: targetData, priceData: targetDataprice, datetimeData: targetDataprice)
////                cell.setValue(priceData: targetDataprice)
//            }
//            
////            if (strPrice != ""){
////                let priceData = TargetDataPrice(priceText: strPrice)
////                
////                cell.setValue(priceData: priceData)
////            }
//            
//            return cell
//        }
//        else{
//            
//            let cell = ShowTargetAllTableViewCell()
//            if (strText != "" && strPrice != ""){
//                let targetData = TargetData(nameTargetText: strText)
//                let targetDataprice = TargetData(priceText: strPrice,datetimeText: strDateTime)
//                
//                cell.setValue(targetData: targetData, priceData: targetDataprice, datetimeData: targetDataprice)
//
//            }
//            return cell
//        }
    }
}
