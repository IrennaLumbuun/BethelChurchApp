//
//  StreamingPopUpViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

// TODO: add a touch event listener so the pop up closes if user touch background

import UIKit
import FirebaseDatabase

class StreamingPopUpViewController: UIViewController {
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var jcBtn: UIButton!
    @IBOutlet weak var gbiBtn: UIButton!
    @IBOutlet weak var byrBtn: UIButton!
    @IBOutlet weak var kidsBtn: UIButton!
    @IBOutlet weak var dmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleRectangularButton(btn: jcBtn)
        Utilities.styleRectangularButton(btn: gbiBtn)
        Utilities.styleRectangularButton(btn: byrBtn)
        Utilities.styleRectangularButton(btn: kidsBtn)
        Utilities.styleRectangularButton(btn: dmBtn)
    }
    
    //If user tapped anywhere not in pop up, redirect to home
    @IBAction func viewTapped(_ sender: Any) {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
            view.window?.rootViewController = homeVC
            view.window?.makeKeyAndVisible()
    }
    

    // TODO: refractor ALL THESE functions
    @IBAction func jcBtnTapped(_ sender: Any) {
        Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            let data = snapshot.value as? NSDictionary
            var url = data?["jc"] as? String ?? ""
            url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
            let toOpen = URL(string: url)
            UIApplication.shared.open((toOpen)!)
          }) {(error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    @IBAction func gbiBtnTapped(_ sender: Any) {
        Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            let data = snapshot.value as? NSDictionary
            var url = data?["gereja"] as? String ?? ""
            url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
            let toOpen = URL(string: url)
            UIApplication.shared.open((toOpen)!)
          }) {(error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    @IBAction func byrBtnTapped(_ sender: Any) {
        Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            let data = snapshot.value as? NSDictionary
            var url = data?["youth"] as? String ?? ""
            url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
            let toOpen = URL(string: url)
            UIApplication.shared.open((toOpen)!)
          }) {(error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    @IBAction func kidsBtnTapped(_ sender: Any) {
        Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            let data = snapshot.value as? NSDictionary
            var url = data?["anak"] as? String ?? ""
            url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
            let toOpen = URL(string: url)
            UIApplication.shared.open((toOpen)!)
          }) {(error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    @IBAction func dmBtnTapped(_ sender: Any) {
        Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            let data = snapshot.value as? NSDictionary
            var url = data?["dm"] as? String ?? ""
            url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
            let toOpen = URL(string: url)
            UIApplication.shared.open((toOpen)!)
          }) {(error) in
            print("error")
            print(error.localizedDescription)
        }
    }
}
