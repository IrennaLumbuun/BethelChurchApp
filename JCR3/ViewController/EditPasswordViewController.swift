//
//  EditPasswordViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 01/08/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditPasswordViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var tutupBtn: UIBarButtonItem!
    @IBOutlet weak var passwordBaruTxt: UITextField!
    @IBOutlet weak var konfirmPasswordTxt: UITextField!
    @IBOutlet weak var simpanPasswordBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        // do styling and whatnot
    }
    
    
    func isPasswordMatch() -> Bool{
        let pass =  passwordBaruTxt.text
        let passKonfirm = konfirmPasswordTxt.text
        if pass != passKonfirm {
            errorLbl.alpha = 1
            errorLbl.text = "Password dan Konfirmasi harus sama."
            return false
        }
        errorLbl.alpha = 0
        return true
    }
    func closePopUp(){
        let profileVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.userProfileViewController) as? UserProfileViewController
        
        navigationController?.pushViewController(profileVC!, animated: true)
    }
    
    @IBAction func tutupBtnTapped(_ sender: Any) {
        print("tutup button")
        closePopUp()
    }
    
    //If user tapped anywhere not in pop up, redirect to home
    @IBAction func viewTapped(_ sender: Any) {
        print("view tapped")
        closePopUp()
    }
    
    @IBAction func simpanBtnTapped(_ sender: Any) {
        //check both text field
        let pass =  passwordBaruTxt.text
        let passKonfirm = konfirmPasswordTxt.text
        
        if pass == "" || passKonfirm == "" {
        errorLbl.text = "Isi  password baru dan konfirmasi password"
        errorLbl.alpha = 1
        }
        
        //if match, change password
        if isPasswordMatch() {
            Auth.auth().currentUser?.updatePassword(to: pass!) { (error) in
                if error != nil{
                    self.errorLbl.text = error?.localizedDescription
                    self.errorLbl.alpha = 1
                }
                else {
                    self.closePopUp()
                }
            }
        }
    }
    
}
