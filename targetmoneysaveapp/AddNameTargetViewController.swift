//
//  AddNameTargetViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class AddNameTargetViewController: UIViewController {
    
    @IBOutlet weak var inputTargetTxt: UITextField!

    var firDataSnapshotArray:[FIRDataSnapshot]! = [FIRDataSnapshot]()
    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        logOut()
        
        if(FIRAuth.auth()?.currentUser == nil){
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginSID")  as! LoginViewController
            
            self.navigationController?.present(loginVC, animated: true, completion: nil)
            
        }
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        databaseInit()
    }
    
    func databaseInit(){
        databaseRef = FIRDatabase.database().reference()
        
        _databaseHandle = self.databaseRef.child("AddTarget").observe(.childAdded, with: { (firebaseSnapshot) in
            self.firDataSnapshotArray.append(firebaseSnapshot)
            
            //let indexPathOfLastRow = IndexPath(row: self.firDataSnapshotArray.count-1, section: 0)
            //self.tableView.insertRows(at: [indexPathOfLastRow], with: .automatic)
            
            
        })
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
        
    }

    @IBAction func btnSendNameTarget(_ sender: Any) {
        
        if((inputTargetTxt.text?.characters.count)! > 0) {
            let nameTargetData = MoneyData(nameTargetText: inputTargetTxt.text!)
            sendTargetName(nameTargetData: nameTargetData)
            inputTargetTxt.text = ""
        }
        
    }
    
    func sendTargetName(nameTargetData: MoneyData) {
        
//        var dataValue = [String: String]()
//        dataValue[MoneyData.NAMETARGET_ID] = nameTargetData.nameTargetText
        
        let dataValue: Dictionary<String, AnyObject> =
        [
            MoneyData.NAMETARGET_ID: nameTargetData.NameTargetText as AnyObject
        ]
        self.databaseRef.child("AddTarget").childByAutoId().setValue(dataValue)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
