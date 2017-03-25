//
//  NetworkService.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

struct NetworkService {
    
    
    var databaseRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    //let databaseRef = FIRDatabase.database().reference()
    //let storageRef = FIRStorage.storage().reference()
    
    private func saveInfo(user: FIRUser!,username: String, password: String) {
        //create our user dictionary info
        let userInfo = ["email": user.email!, "username": username, "uid": user.uid, "photoUrl":String(describing: user.photoURL)]
        //create user reference
        let userRef = databaseRef.child("user").child(user.uid)
        //save the user into database 
        userRef.setValue(userInfo)
        
        signIn(email: user.email!, password: password)
        
    }
    
    func signIn(email:String, password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error==nil {
                if let user = user {
                    print("sign in successful")
                }
            }else {
                print(error!.localizedDescription)
            }
        })
    }
    
    private func setUserInfo(user: FIRUser!, username: String, password: String, data: NSData) {
        //Creat path for the user image
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        //Creat image Reference
        let imageRef = storageRef.child(imagePath)
        //Create Metadata for the image
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //Save the user Image in the Firebase Storage File
        imageRef.put(data as Data, metadata: metaData) {(metaData, error) in
            
            if error == nil {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    
                    if error == nil{
                        self.saveInfo(user: user,username:username, password: password)
                    }else {
                        print(error?.localizedDescription)
                    }
                    
                })
            }else {
                print(error?.localizedDescription)
            }
        
        }
    }
    
    func signUp(email: String, username: String, password: String, data: NSData!){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user: user, username: username, password: password, data: data)
            }else {
                print(error?.localizedDescription)
            }
        })
    }
    
    func resetPassword(email: String) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("ระบบกำลังส่งอีเมล์เพื่อเปลี่ยนรหัสผ่านใหม่ของคุณ")
            }
        })
    }

}
    
    
    
