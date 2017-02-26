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

    var firDataSnapshotArray:[FIRDataSnapshot]! = [FIRDataSnapshot]()
    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        logOut()
//        
//        if(FIRAuth.auth()?.currentUser == nil){
//            
//            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginSID")  as! LoginViewController
//            
//            self.navigationController?.present(loginVC, animated: true, completion: nil)
//            
//        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        databaseInit()
    }
    
    func databaseInit(){
        databaseRef = FIRDatabase.database().reference()
        
        _databaseHandle = self.databaseRef.child("AddTarget").observe(.childAdded, with: { (firebaseSnapshot) in
            self.firDataSnapshotArray.append(firebaseSnapshot)
            
            let indexPathOfLastRow
                = IndexPath(row: self.firDataSnapshotArray.count-1, section: 0)
            self.tableView.insertRows(at: [indexPathOfLastRow], with: .automatic)
            
            
        })
    }
    
    func databaseRelease(){
        if(_databaseHandle == nil) {
            self.databaseRef.child("AddTarget").removeObserver(withHandle: _databaseHandle)
            _databaseHandle = nil
        }
    }
    
    
//    func logOut() {
//        do{
//            try FIRAuth.auth()?.signOut()
//        }
//        catch let error as NSError{
//            print(error.localizedDescription)
//        }
//    }
    
    
    deinit {
        databaseRelease()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return MoneyDataArray.count
        return firDataSnapshotArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let firDataSnapshot = self.firDataSnapshotArray[indexPath.row]
        let snapShotValue = firDataSnapshot.value as! Dictionary<String, AnyObject>
        
        var strText = ""
        
        if let tempstrText = snapShotValue[TargetData.NAMETARGET_ID] as! String! {
            strText = tempstrText
        }
        
        var strPrice = ""
        
        if let tempsstrPrice = snapShotValue[TargetData.PRICETEXT_ID] as! String! {
            strPrice = tempsstrPrice
        }
        
        var strDateTime = ""
        if let tempstrDateTime = snapShotValue[MoneyData.DATETIMETEXT_ID] as! String! {
            strDateTime = tempstrDateTime
        }

        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTargetViewCell") as? ShowTargetAllTableViewCell {
            
            if (strText != "" && strPrice != "" ){
                let targetData = TargetData(nameTargetText: strText)
                let targetDataprice = TargetData(priceText: strPrice, datetimeText: strDateTime)
                
                cell.setValue(targetData: targetData, priceData: targetDataprice)
//                cell.setValue(priceData: targetDataprice)
            }
            
//            if (strPrice != ""){
//                let priceData = TargetDataPrice(priceText: strPrice)
//                
//                cell.setValue(priceData: priceData)
//            }
            
            return cell
        }
        else{
            
            let cell = ShowTargetAllTableViewCell()
            if (strText != "" && strPrice != ""){
                let targetData = TargetData(nameTargetText: strText)
                let targetDataprice = TargetData(priceText: strPrice,datetimeText: strDateTime)
                
//                cell.setValue(targetData: targetData)
//                cell.setValue(priceData: targetDataprice)
                cell.setValue(targetData: targetData, priceData: targetDataprice)
            }
            return cell
        }
    }
}
