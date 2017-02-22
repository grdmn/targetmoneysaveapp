//
//  SignupViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/27/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    
    var authListener: FIRAuthStateDidChangeListenerHandle?
    
    
    @IBAction func registerButtonTouch(_ sender: Any) {
        
        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["email": self.emailTextField.text, "name": self.nameTextField.text]
            usersReference.updateChildValues(values, withCompletionBlock: {(error,ref) in
                if error != nil{
                    print(error!)
                    return
                }
                
                print("save user successful into firebase db")
                
                
            })
            
            

            
            
            
        }
        
        
    }
    
    
    @IBAction func profileImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profilePicture.image = originalImage
            profilePicture.contentMode = .scaleAspectFit
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        dismiss(animated: true, completion: nil)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authListener = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                //self.gotoDashboard()
                self.gotoProfile()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func gotoDashboard() {
        let dashboardNav = self.storyboard?.instantiateViewController(withIdentifier: "NavDashboardViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = dashboardNav
    }
    
    func gotoProfile() {
        let profileNav = self.storyboard?.instantiateViewController(withIdentifier: "NavProfileViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = profileNav
    }

    

}
