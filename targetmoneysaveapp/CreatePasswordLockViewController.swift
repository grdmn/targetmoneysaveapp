//
//  CreatePasswordLockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/2/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CreatePasswordLockViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTextField:UITextField!
    
    var authListener: FIRAuthStateDidChangeListenerHandle?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("PasswordlogPiggybank").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild((FIRAuth.auth()?.currentUser?.uid)!){
                
                print("true rooms exist")
                self.gotoCannotUnlockPage()
                
            }else{
                
                print("false room doesn't exist")
            }
            
            
        })

        
        
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

    
    
    @IBAction func createpasswordClicked(_ sender: Any) {
        
        if (passwordTextField.text!.characters.count<6) {
            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
            return
        }
        else{
            passwordTextField.backgroundColor = UIColor.white
        }
        
    
        //let password = passwordTextField.text!
        
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let usersReference = ref.child("PasswordlogPiggybank").child((FIRAuth.auth()?.currentUser?.uid)!)
        let value = ["password": self.passwordTextField.text, "user": FIRAuth.auth()?.currentUser?.displayName, "email": FIRAuth.auth()?.currentUser?.email]
        usersReference.updateChildValues(value as Any as! [AnyHashable : Any], withCompletionBlock: {(error,ref) in
            if error != nil{
                print(error!)
                return
            }
            
            print("save password successful into firebase db")
            
            self.gotoHome()
            
            
        })

        
    
}
    
    
    func gotoCannotUnlockPage() {
        let CannotUnlockNav = self.storyboard?.instantiateViewController(withIdentifier: "CannotUnlockPageViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = CannotUnlockNav
    }
    
    func gotoHome() {
        let CannotUnlockNav = self.storyboard?.instantiateViewController(withIdentifier: "HomeUITabBarController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = CannotUnlockNav
    }
    
    
    
    
    





}
