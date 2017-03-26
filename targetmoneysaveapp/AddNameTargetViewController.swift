//
//  AddNameTargetViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class AddNameTargetViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var inputTargetTxt: UITextField!
    @IBOutlet weak var MyImageView:UIImageView!

    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
        
//        logOut()
//        
//        if(FIRAuth.auth()?.currentUser == nil){
//            
//            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginSID")  as! LoginViewController
//            
//            self.navigationController?.present(loginVC, animated: true, completion: nil)
//            
//        }
        
        
    }
    
    @IBAction func PhotoAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    
    @IBAction func CameraAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
    }
    
    func uploadImageToFirebaseStorageData(data: NSData){
        
        let storageRef = FIRStorage.storage().reference(withPath: "myTargetPics/demoPic.jpg")
        let uploadMetadata = FIRStorageMetadata()
        uploadMetadata.contentType = "\(UUID().uuidString).jpeg"
        storageRef.put(data as Data, metadata: uploadMetadata, completion: {(metadata, error)in
            if(error != nil){
                print("error")
            }else{
                let downLoadURL = metadata?.downloadURL()
                self.navigationController?.popViewController(animated: true)
                
                
            }
            
        })
        
    }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let imageData = UIImageJPEGRepresentation(image, 0.8){
            
            uploadImageToFirebaseStorageData(data: imageData as NSData)
            
            MyImageView.image = image
            MyImageView.contentMode = .scaleAspectFit
            self.dismiss(animated: true, completion: nil)
        }
    }


//    func logOut() {
//        do{
//            try FIRAuth.auth()?.signOut()
//        }
//        catch let error as NSError{
//            print(error.localizedDescription)
//        }
//    }
    

    @IBAction func btnSendNameTarget(_ sender: Any) {
        
        if(inputTargetTxt.text!.characters.count < 0) {
            Const().showAlert(title: "Error", message: "กรุณากรอกจำนวนเงิน", viewController: self)
            return
        }
        else{
            inputTargetTxt.backgroundColor = UIColor.white
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        
        let usersReference = ref.child("Target").child((FIRAuth.auth()?.currentUser?.uid)!)
        let timestamp = CurrentDateTimeToStr()
        
        let addPriceData = ["NameTarger": self.inputTargetTxt.text!,"Time": timestamp] as [String : Any]
        
        usersReference.updateChildValues(addPriceData)
        
        
    }
    
    func CurrentDateTimeToStr() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: currentDate)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
