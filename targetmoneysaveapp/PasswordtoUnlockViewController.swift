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
    
    var calPassword:String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        checkPassword()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unlockClicked (_ sender: Any){

        passwordcheck()
        
    
        
    }
    
    
    func checkPassword () {
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("PasswordlogPiggybank").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["password"] as? String ?? ""
            
            print(username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

    }

    func passwordcheck() {
        
        
        if (FIRAuth.auth()?.currentUser) != nil {
            
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("PasswordlogPiggybank").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                
                
                let value = snapshot.value as? NSDictionary
                let coinB = value?["password"] as? Int
                self.calPassword = coinB!.description
                
                // ...
            })
            print("password is " , calPassword)
            
            cal()
            
            
        } else {
            let alert = UIAlertController(title: "ผิดพลาด!", message: "ไม่มีผู้เข้าสู่ระบบ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction) in
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }

        
    }
    
    func cal() {
        
        print("calcoin",calPassword)
        
        if confirmPasswordTextField.text == calPassword{
            
            print("Equal")
            UnlockDecision()
            
        }else {
            print("No data")
            
        }
        
    }
    
    func dismissKeyboard() {
        //view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func UnlockDecision() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UnlockDecision") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view
        
    }

    
    
}

