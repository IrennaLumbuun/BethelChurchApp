//
//  LandingPageViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 25/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth

class LandingPageViewController: UIViewController {

    @IBOutlet weak var jcLogoImg: UIImageView!
    @IBOutlet weak var masukEmailBtn: UIButton!
    @IBOutlet weak var masukHpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.initiateBackground(imageName: "welcome.jpg", view: self)
        //self.setJcLogo() <-- do we use logo?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear is called")
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil{
                self.transitionToHome()
            }
        }
    }
    
    /*
    func setJcLogo(){
        self.jcLogoImg.image = UIImage.init(named: "iconjc.png")
        self.jcLogoImg.layer.borderWidth = 5
        self.jcLogoImg.layer.borderColor = UIColor.orange.cgColor
        self.jcLogoImg.layer.cornerRadius = jcLogoImg.frame.height/1.75
        self.jcLogoImg.frame.size = CGSize(width: 150, height:150)
        self.jcLogoImg.center = CGPoint(x: self.view.center.x, y: 200)
    }*/
    
    func initiateBackground() {
        let backgroundImage = UIImage.init(named: "welcome.jpg")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)

        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill

        self.view.insertSubview(backgroundImageView, at: 0)
    }
    
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
}
