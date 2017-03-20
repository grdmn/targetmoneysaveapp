//
//  CreatePasswordLockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/2/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class CreatePasswordLockViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTextField:UITextField!
    
    var authListener: FIRAuthStateDidChangeListenerHandle?
    
    var userEmail:String! = ""
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let ref = FIRDatabase.database().reference()
//        ref.child("testUser").observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if snapshot.hasChild("passwordlock"){
//                
//                print("true rooms exist")
//                    self.gotoCannotUnlockPage()
//                
//                
//            }else{
//                
//                print("false room doesn't exist")
//            }
//            
//            
//        })
        
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
        let usersReference = ref.child("testUser/passwordlock")
        let values = ["passwordunlock": self.passwordTextField.text]
        usersReference.updateChildValues(values, withCompletionBlock: {(error,ref) in
            if error != nil{
                print(error!)
                return
            }
            
            print("save password successful into firebase db")
            
            
        })

        
    
}


    override func viewWillAppear(_ animated: Bool) {
    
          getUserEmail()

    }



    func getUserEmail() {

        let firAuthEmail = FIRAuth.auth()?.currentUser?.email

        if firAuthEmail != nil{
            userEmail = firAuthEmail
            userEmail = replaceSpacialCharacter(inputStr: userEmail)

        }

    }
    

    func replaceSpacialCharacter(inputStr: String) -> String  {
        var outputStr = inputStr

        outputStr = outputStr.replacingOccurrences(of: ".", with: "dot")
        outputStr = outputStr.replacingOccurrences(of: "#", with: "sharp")
        outputStr = outputStr.replacingOccurrences(of: "$", with: "dollar")
        outputStr = outputStr.replacingOccurrences(of: "[", with: "stasign")
        outputStr = outputStr.replacingOccurrences(of: "]", with: "endsign")

        return outputStr

    }
    
//    func gotoCannotUnlockPage() {
//        let CannotUnlockNav = self.storyboard?.instantiateViewController(withIdentifier: "CannotUnlockViewController")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = CannotUnlockNav
//    }





}
