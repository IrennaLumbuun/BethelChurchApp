//
//  LogInViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 23/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EmailLoginViewController: UIViewController {

    //outlet
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var masukBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    

    @IBOutlet weak var lupaPasswordPopUp: UIView!
    @IBOutlet weak var lupaPasswordBtn: UIButton!
    @IBOutlet weak var tutupBtn: UIButton!
    @IBOutlet weak var recoveryEmailTxt: UITextField!
    @IBOutlet weak var errorRecoverLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLbl.alpha = 0
        lupaPasswordPopUp.alpha = 0
        errorRecoverLbl.alpha = 0
        Utilities.initiateBackground(imageName: "welcome.jpg", view: self)
        // TODO: style other elements?
    }
    
    func validateFields() -> String? {
        if emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Semua textbox harus diisi"
        }
        return nil
    }
    
    /*
     * When button masuk is tapped:
     * we verify that all fields are filled in
     * call signIn API
     * if user is not found, then they are new users
     */
    @IBAction func masukBtnTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            // show error
            errorLbl.text = error
            errorLbl.alpha = 1
        } else {
            let email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password){
                (result, error) in
                if error != nil{
                    let errorCode = AuthErrorCode(rawValue: error!._code)
                    // fail to sign in because user does not exist
                    // we redirect to sign up page
                    if errorCode == AuthErrorCode.userNotFound{
                        print("user not found")
                        Auth.auth().createUser(withEmail: email, password: password) { (success, error) in
                            if error != nil {
                                self.errorLbl.text = error?.localizedDescription
                                self.errorLbl.alpha = 1
                            } else {
                                self.transitionToDaftar()
                            }
                        }
                    }
                    else {
                        self.errorLbl.text = error?.localizedDescription
                        self.errorLbl.alpha = 1
                    }
                }
                else{
                    print("success")
                    print(email)
                    print(password)
                    self.transitionToHome()
                }
            }
        }
    }
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToDaftar(){
        let daftarVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.daftarViewController) as? DaftarViewController
        
        view.window?.rootViewController = daftarVC
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func showLupaPasswordPopUp(_ sender: Any) {
        lupaPasswordPopUp.alpha = 1
        recoveryEmailTxt.text = emailTxt.text
    }
    @IBAction func lupaPasswordBtnTapped(_ sender: Any) {
        let email = recoveryEmailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if email == "" {
            errorRecoverLbl.text = "Isi emailmu"
            self.errorRecoverLbl.alpha = 1
        }
        //assume no errors because I am tireddd
        Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
            if error == nil{
                self.lupaPasswordPopUp.alpha = 0
                //tell user email is OTW
            } else {
            self.errorRecoverLbl.text = error?.localizedDescription
            self.errorRecoverLbl.alpha = 1
            }
        }
    }
    
    @IBAction func tutupBtnTapped(_ sender: Any) {
        lupaPasswordPopUp.alpha = 0
    }
}
