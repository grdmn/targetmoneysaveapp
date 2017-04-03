//
//  PasswordtoUnlockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/2/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class PasswordtoUnlockViewController: UIViewController {
    
    @IBOutlet weak var confirmPasswordTextField:UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        checkPassword()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unlockClicked (_ sender: Any){
        
        
        if (confirmPasswordTextField.text!.characters.count<6) {
            Const().showAlert(title: "เดี๋ยวนะ", message: "รหัสผ่านต้องมีมากกว่า 6 ตัว", viewController: self)
            return
        }
        else{
            confirmPasswordTextField.backgroundColor = UIColor.white
        }
    
        
        
    }
    
    
    func checkPassword () {
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let userID = FIRAuth.auth()?.currentUser?.uid
        
//        ref.child("PasswordlogPiggybank").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["password"] as? String ?? ""
//            
//            print(username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }

    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

