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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    
    //var MoneyDataArray = [MoneyData]()
    
    var firDataSnapshotArray:[FIRDataSnapshot]! = [FIRDataSnapshot]()
    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    

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
        
//        var moneyData = MoneyData(moneyText: "Test1")
//        MoneyDataArray.append(moneyData)
//        moneyData = MoneyData(moneyText: "Test2")
//        MoneyDataArray.append(moneyData)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        databaseRelease()
        databaseInit()
    }
    
    func databaseInit(){
        databaseRef = FIRDatabase.database().reference()
        
        _databaseHandle = self.databaseRef.child("MoneyStatus").observe(.childAdded, with: { (firebaseSnapshot) in
            self.firDataSnapshotArray.append(firebaseSnapshot)
            
            let indexPathOfLastRow = IndexPath(row: self.firDataSnapshotArray.count-1, section: 0)
            self.tableView.insertRows(at: [indexPathOfLastRow], with: .automatic)
            
            
        })
    }
    
    func databaseRelease(){
        if(_databaseHandle = nil) {
            self.databaseRef.child("MoneyStatus").removeObserver(withHandle: _databaseHandle)
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
        //return 4
        return MoneyDataArray.count
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
    
    override func viewDidDisappear(_ animated: Bool) {
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
