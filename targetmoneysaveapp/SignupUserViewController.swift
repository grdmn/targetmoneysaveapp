//
//  SignupUserViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class SignupUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameTextField:UITextField!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    let networkingService = NetworkService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
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

    
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        networkingService.signUp(email: emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, data: data as NSData!)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeUITabBarController")
        present(vc, animated: true, completion: nil)
        
        
        

    }
}
