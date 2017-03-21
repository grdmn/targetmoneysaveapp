//
//  ProfileViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/27/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var emailValueLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let logoutBarButton = UIBarButtonItem(title: "ออก", style: .plain, target: self, action: #selector(logout))
        let manageProfileBarButton = UIBarButtonItem(title: "แก้ไข", style: .plain, target: self, action: #selector(manageProfile))
        self.navigationItem.leftBarButtonItem = logoutBarButton
        self.navigationItem.rightBarButtonItem = manageProfileBarButton
//        
//        if let user = FIRAuth.auth()?.currentUser{
//            setUserDataToView(withFIRUser: user)
//            
//            if user.isEmailVerified {
//                AppDelegate.showAlertMsg(withViewController:self, message: "Your Account is not verified, Please Select '+' to verified it!!!")
//            } else {
//                let alert = UIAlertController(title: "Message", message: "No user is signed in", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
//                    self.logout()
//                })
//                alert.addAction(okAction)
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
        

    }
    
    // MARK: - Method
    
    func logout() {
        let loginNav = self.storyboard?.instantiateViewController(withIdentifier: "LoginSID")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginNav
        
        try! FIRAuth.auth()!.signOut()
    }
    
    func manageProfile() {
        let manageActionSheet = UIAlertController(title: "Select menu", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        let changeEmailAction = UIAlertAction(title: "Change Email", style: .default) { (action: UIAlertAction) in
            self.changeEmail()
        }
        
        let deleteAccountAction = UIAlertAction(title: "Delete Account", style: .default) { (action: UIAlertAction) in
            self.deleteAccount()
        }
        
        if let user = FIRAuth.auth()?.currentUser, !user.isEmailVerified {
            let verifyAccountAction = UIAlertAction(title: "Verify Account", style: .default) { (action: UIAlertAction) in
                self.sentVerifiedEmail()
            }
            manageActionSheet.addAction(verifyAccountAction)
        }
        manageActionSheet.addAction(changeEmailAction)
        manageActionSheet.addAction(deleteAccountAction)
        manageActionSheet.addAction(cancelAction)
        
        self.present(manageActionSheet, animated: true, completion: nil)
    }
    
    func changePassword() {
        let alert = UIAlertController(title: "Change Password", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter your new password"
            textField.clearButtonMode = .whileEditing
            textField.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
            let textField = alert.textFields![0]
            let user = FIRAuth.auth()?.currentUser
            user?.updatePassword(textField.text!) { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Password was updated")
                }
            }
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    func changeEmail() {
        let alert = UIAlertController(title: "Change Email", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter your new email"
            textField.clearButtonMode = .whileEditing
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
            let textField = alert.textFields![0]
            let user = FIRAuth.auth()?.currentUser
            user?.updateEmail(textField.text!) { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Email was updated. You have to login again.")
                    self.logout()
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteAccount() {
        let alert = UIAlertController(title: "Delete Account", message: "This account will be deleted. This operation can not undo. Are you sure?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
            if let user = FIRAuth.auth()?.currentUser {
                let alert = UIAlertController(title: "Delete Account", message: "[\(user.email!)] will be deleted. This operation can not undo. Are you sure?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
                    user.delete { error in
                        if let error = error {
                            AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                        } else {
                            AppDelegate.showAlertMsg(withViewController: self, message: "[\(user.email!)] was deleted")
                            self.logout()
                        }
                    }
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func sentVerifiedEmail() {
        if let user = FIRAuth.auth()?.currentUser {
            user.sendEmailVerification() { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Email verification has been sent to [\(user.email!)]. Please check your email and verify it. Then login again.")
                    self.logout()
                }
            }
        }
    }
    
//    func setUserDataToView(withFIRUser user: FIRUser) {
//        
//        emailValueLabel.text = user.email
//        nameValueLabel.text = user.displayName
//    }


}
