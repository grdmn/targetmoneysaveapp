//
//  ComposeViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/10/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var MyImageView: UIImageView!

    
    var ref:FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
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
    
    func uploadImageToFirebaseStorageData(data: NSData){
        
        let storageRef = FIRStorage.storage().reference(withPath: "myTargetPics/demoPic.jpg")
        let uploadMetadata = FIRStorageMetadata()
        uploadMetadata.contentType = "image/jpg"
        storageRef.put(data as Data, metadata: uploadMetadata, completion: {(metadata, error)in
            if(error != nil){
                print("error")
            }else{
                print("upload complete")
            }
        
        })
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let imageData = UIImageJPEGRepresentation(image, 0.8){
            
            uploadImageToFirebaseStorageData(data: imageData as NSData)
            
            MyImageView.image = image
            MyImageView.contentMode = .scaleAspectFit
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        let imagedata = UIImageJPEGRepresentation(MyImageView.image!, 0.6)
        let compressImage = UIImage(data:imagedata!)
        UIImageWriteToSavedPhotosAlbum(compressImage!, nil, nil, nil)
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addPost(_ sender: Any) {
        
        // TODO: Post the data to firebase
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        ref?.child("Posts/photoURL").setValue(MyImageView.image)
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addPostfirst(_ sender: Any) {
        
        // TODO: Post the data to firebase
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cancelPost(_ sender: Any) {
        
        
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    //get money
    @IBAction func getmoney(_ sender: Any) {
        
        
        
    }
    
    
    
    
    

}
