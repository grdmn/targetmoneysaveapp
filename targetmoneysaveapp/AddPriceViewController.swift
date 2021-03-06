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
        
        
        if (inputPriceTxt.text!.characters.count < 0) {
            Const().showAlert(title: "Error", message: "กรุณากรอกจำนวนเงิน", viewController: self)
            return
        }
        else{
            inputPriceTxt.backgroundColor = UIColor.white
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        
        let pricelabel = inputPriceTxt.text
        let pricetextfromstring = Int(pricelabel!)
        
        let usersReference = ref.child("Target").child((FIRAuth.auth()?.currentUser?.uid)!)
        
        let addPriceData = ["Price": pricetextfromstring! , "Username":FIRAuth.auth()?.currentUser?.email as Any]
        usersReference.setValue(addPriceData)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        
//        let ref = FIRDatabase.database().reference()
//        
//        ref.child("Target").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if snapshot.hasChild("NameTarger"){
//                
//                print("true rooms exist")
//                self.showTargetAccept()
//                
//                
//            }else{
//                
//                print("false room doesn't exist")
//                
//            }
//            
//            
//        })
        
        
    }
    
    
//    func showTargetAccept() {
//        let showTargetAccept = self.storyboard?.instantiateViewController(withIdentifier: "TargetDetail")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = showTargetAccept
//    }

    
    
    func dismissKeyboard() {
        //        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   
}
