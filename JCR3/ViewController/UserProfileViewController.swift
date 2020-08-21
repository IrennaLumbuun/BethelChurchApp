//
//  UserProfileViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileViewController: UIViewController {

    @IBOutlet weak var MainVerticalStack: UIStackView!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var GreetingLbl: UILabel!
    @IBOutlet weak var PhoneNumberLbl: UILabel!
    @IBOutlet weak var BtnGroupHorizontalStack: UIStackView!
    @IBOutlet weak var GemarBtn: UIButton!
    @IBOutlet weak var EditProfileBtn: UIButton!
    @IBOutlet weak var BadgeBtn: UIButton!
    @IBOutlet weak var RequestPengerjaBtn: UIButton!
    @IBOutlet weak var ChangePasswordBtn: UIButton!
    @IBOutlet weak var RatingBtn: UIButton!
    @IBOutlet weak var SignOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup(){
        renderLabel()
        styleItem()
        // render pic to profilePic ImageView
        let name = Auth.auth().currentUser!.displayName?.uppercased() ?? "X"
        let imageName = String(name[name.startIndex]) + ".png"
        self.ProfilePic.image = UIImage.init(named: imageName)
    }
    
    func renderLabel(){
        let phoneNumber = Auth.auth().currentUser?.phoneNumber
        let email = Auth.auth().currentUser?.email
        GreetingLbl.text = "Shalom! \(Auth.auth().currentUser?.displayName ?? "Jane Doe")"
        PhoneNumberLbl.text = phoneNumber != nil ? phoneNumber : email
    }
    
    func styleItem(){
        
    }
    
    @IBAction func requestPengerjaTapped(_ sender: Any) {
        Utilities.requestPengerja()
    }
    @IBAction func changePasswordTapped(_ sender: Any) {
        // bikin pop up
    }
    @IBAction func ratingBtnTapped(_ sender: Any) {
        //redirect to url
    }
    
    // user signs out
    // go back to landingpage
    @IBAction func signOutBtnTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.transitionToLandingPage()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    func transitionToLandingPage(){
        let landingPageVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.landingPageViewController) as? LandingPageViewController
        
        view.window?.rootViewController = landingPageVC
        view.window?.makeKeyAndVisible()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        //transition to home
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        homeVC?.modalPresentationStyle = .fullScreen
        homeVC?.modalTransitionStyle = .coverVertical
        present(homeVC!, animated: true, completion: nil)
    }
    
}

