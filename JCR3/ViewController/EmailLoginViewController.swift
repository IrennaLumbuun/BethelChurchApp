//
//  LogInViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 23/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailLoginViewController: UIViewController {

    //outlet
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var masukBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLbl.alpha = 0
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
                        self.transitionToDaftar()
                    }
                    else{
                        self.errorLbl.text = error?.localizedDescription
                        self.errorLbl.alpha = 1
                    }
                }
                else{
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
}
