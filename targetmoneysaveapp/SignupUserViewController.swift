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
    var pickerView: UIPickerView!
    let networkingService = NetworkService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func choosePicker(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "เพิ่มรูปภาพของคุณ", message: "เลือกจาก", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "กล้อง", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "รูปถ่าย", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let savePhotoAction = UIAlertAction(title: "บันทึก", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        
        let cancleAction = UIAlertAction(title: "ยกเลิก", style: .destructive, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(savePhotoAction)
        
        
        present(alertController, animated: true, completion:nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            userImageView.image = image
            self.dismiss(animated: true, completion: nil)
            
    
}
    
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        networkingService.signUp(email: emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, data: data as NSData!)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeUITabBarController")
        present(vc, animated: true, completion: nil)

    }
}
