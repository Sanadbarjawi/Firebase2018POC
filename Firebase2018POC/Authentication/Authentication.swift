//
//  Authentication.swift
//  Firebase2018POC
//
//  Created by Sanad  on 2/26/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import Firebase

class Authentication: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        userNameTxtField.text = ""
        passwordTxtField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()//To hide keyboard when tapped around (vc extention)
        RegisterButton.layer.borderWidth = 1
        RegisterButton.layer.borderColor = UIColor.white.cgColor
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    @IBAction func signInBtnPressed(_ sender: Any) {//Signing-In process
        if userNameTxtField.text != "" && passwordTxtField.text != ""{
            activityIndicator.startAnimating()
            Auth.auth().signIn(withEmail: userNameTxtField.text!, password: passwordTxtField.text!) { (user, error) in
                self.activityIndicator.startAnimating()
                if error == nil {
                    print("SignIn Successful!")
                    self.activityIndicator.stopAnimating()
                    //////
                    //success code here
                    let vc = LandingPage(nibName: "LandingPage", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                    //////
                }else{
                    let message = error?.localizedDescription
                    let Alert = UIAlertController(title: "Sign In", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        self.activityIndicator.stopAnimating()
                        Alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(Alert, animated: true, completion: nil)
                }
            }
        }else{
            let Alert = UIAlertController(title: "Required fields", message: "email or password is empty", preferredStyle: UIAlertControllerStyle.alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                Alert.dismiss(animated: true, completion: nil)
            }))
            self.present(Alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func registerBtnPressed(_ sender: Any) {//Registeration process
        dismissKeyboard()
        if userNameTxtField.text != "" && passwordTxtField.text != ""{
            activityIndicator.startAnimating()

            Auth.auth().createUser(withEmail: userNameTxtField.text!, password: passwordTxtField.text!) { (user, error) in
                if error == nil {
                    self.activityIndicator.stopAnimating()
                    print("Registeration Successful!")
                    //////
                    //success code here
                    let vc = LandingPage(nibName: "LandingPage", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                    //////
                }else{
                    let message = error?.localizedDescription
                    let Alert = UIAlertController(title: "Registeration", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        self.activityIndicator.stopAnimating()
                        Alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(Alert, animated: true, completion: nil)
                }
            }
        }else{
            let Alert = UIAlertController(title: "Required fields", message: "email or password is empty", preferredStyle: UIAlertControllerStyle.alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                Alert.dismiss(animated: true, completion: nil)
            }))
            self.present(Alert, animated: true, completion: nil)
        }
    }
    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: userNameTxtField.text!) { (error) in
            if error == nil {
                print("Reset password send")
                //////
                //success code here
                let Alert = UIAlertController(title: "RESET PASSWORD", message: "Check your email inbox to reset password", preferredStyle: UIAlertControllerStyle.alert)
                Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    Alert.dismiss(animated: true, completion: nil)
                }))
                self.present(Alert, animated: true, completion: nil)
                //////
            }else{
                print(error!)
            }
        }
    }
    
}
