//
//  LandingPage.swift
//  Firebase2018POC
//
//  Created by Sanad  on 2/26/18.
//  Copyright © 2018 Sanad . All rights reserved.


import UIKit
import Firebase

class LandingPage: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var displayNameTxtField: UITextField!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var locationTxtField: UITextField!
    
    //properties
    var UserID = ""
    var UserEmail = ""
    var displayName = ""
    var ref:DocumentReference? = nil
    let db = Firestore.firestore()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserID = UserDefaults.standard.string(forKey: "userId")!
        UserEmail = UserDefaults.standard.string(forKey: "userEmail")!
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: UserEmail).getDocuments{(snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if (document.data()["displayName"] as? String) != nil {
                        let vc = addFriendsViewController(nibName: "addFriendsViewController", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        proceedBtn.layer.borderWidth = 1
        proceedBtn.layer.borderColor = UIColor.white.cgColor
        hideKeyboardWhenTappedAround()
     
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = Authentication(nibName: "Authentication", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        } catch  {
            print("Invalid Selection.")
        }
    }
    @IBAction func proceedBtnPressed(_ sender: Any) {
        displayName = displayNameTxtField.text!
        
        ref = db.collection("users").addDocument(data: [
            "displayName":displayNameTxtField.text!,
            "id":UserID,
            "email":UserEmail,
            "location":locationTxtField.text!
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
        let vc = addFriendsViewController(nibName: "addFriendsViewController", bundle: nil)
        vc.location = locationTxtField.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
