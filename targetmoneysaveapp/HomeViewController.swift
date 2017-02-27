//
//  HomeViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    
    var MoneyDataArray = [MoneyData]()
    
//    var postDataDash = [MoneyData]()
    
//    var firDataSnapshotArray:[FIRDataSnapshot]! = [FIRDataSnapshot]()
    
    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    
//    var userEmail:String! = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        logOut()
        
        if(FIRAuth.auth()?.currentUser == nil){
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginSID")  as! LoginViewController
        
            self.navigationController?.present(loginVC, animated: true, completion: nil)
            
        }
        
        FIRMessaging.messaging().subscribe(toTopic: "/topic/news")


    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//      getUserEmail()
        databaseInit()
        databaseRelease()
    }
    
//    func getUserEmail() {
//        
//        let firAuthEmail = FIRAuth.auth()?.currentUser?.email
//        
//        if firAuthEmail != nil{
//            userEmail = firAuthEmail
//            userEmail = replaceSpacialCharacter(inputStr: userEmail)
//            
//            databaseRelease()
//            databaseInit()
//        
//        }
//        
//    }
    
//    func replaceSpacialCharacter(inputStr: String) -> String  {
//        var outputStr = inputStr
//        
//        outputStr = outputStr.replacingOccurrences(of: ".", with: "dot")
//        outputStr = outputStr.replacingOccurrences(of: "#", with: "sharp")
//        outputStr = outputStr.replacingOccurrences(of: "$", with: "dollar")
//        outputStr = outputStr.replacingOccurrences(of: "[", with: "stasign")
//        outputStr = outputStr.replacingOccurrences(of: "]", with: "endsign")
//        
//        return outputStr
//        
//    }
    
    func databaseInit(){
        
        databaseRef = FIRDatabase.database().reference()
        
        _databaseHandle = self.databaseRef.child("StatusMoney").observe(.value, with: {
            (firebaseSnapshot) in
            
            self.MoneyDataArray = []
            
            if let snapshot = firebaseSnapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let snapValue = snap.value as? Dictionary<String, AnyObject>
                    {
                        let key = snap.key
                        let moneyData = MoneyData(priKey: key, data: snapValue)
                        self.MoneyDataArray.append(moneyData)
                    }
                    
                }
            }
            self.tableView.reloadData()
        })
        
    }
    
    func databaseRelease(){
        if(_databaseHandle == nil) {
            self.databaseRef.child("StatusMoney").removeObserver(withHandle: _databaseHandle)
            _databaseHandle = nil
        }
    }
    
    
    func logOut() {
        do{
            try FIRAuth.auth()?.signOut()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    
    deinit {
        databaseRelease()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoneyDataArray.count
//        return firDataSnapshotArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let moneyData = MoneyDataArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StatusMoneyCell") as? StatusMoneyTableViewCell {
            cell.setValue(moneyData: moneyData)
            
            return cell
        }
        else{

            let cell = StatusMoneyTableViewCell()
            cell.setValue(moneyData: moneyData)
            
            return cell
            
        }

    }

}
