//
//  StreamingPopUpViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StreamingPopUpViewController: UIViewController {
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var jcBtn: UIButton!
    @IBOutlet weak var gbiBtn: UIButton!
    @IBOutlet weak var byrBtn: UIButton!
    @IBOutlet weak var kidsBtn: UIButton!
    @IBOutlet weak var dmBtn: UIButton!
    
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var bottomStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        styleBtn(btn: jcBtn, image: "Logo.png")
        styleBtn(btn: gbiBtn, image: "gbi.png")
        styleBtn(btn: byrBtn, image: "byr.jpeg")
        styleBtn(btn: kidsBtn, image: "kids.png")
        styleBtn(btn: dmBtn, image: "dm.jpeg")*/
        stylePopup()
        
    }
    
    func stylePopup() {
        let popupHeight = self.view.frame.height / 5
        self.PopUpView.frame = CGRect(x: 20, y: (self.view.frame.height - popupHeight) / 2, width: self.view.frame.width - 40, height: popupHeight)
        
        let stackHeight = popupHeight/2
        self.topStack.frame = CGRect(x: 20, y: (self.view.frame.height - popupHeight) / 2, width: self.view.frame.width - 40, height: stackHeight)
        self.bottomStack.frame = CGRect(x: 20, y: (self.view.frame.height - popupHeight) / 2 + stackHeight, width: self.view.frame.width - 40, height: stackHeight)
    }
    
    //TODO: fix this so the background is contained inside image
    func styleBtn(btn: UIButton, image: String){
        let popUpWidth = PopUpView.frame.width
        
        btn.layer.cornerRadius = 5
        //btn.setImage(UIImage.init(named: image), for: .normal)
        
        // assign insets
        btn.imageEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0)
        print("after inset -> \(btn.frame.size.height)")
        btn.imageView?.contentMode = .scaleToFill
        
        let btnWidth = (popUpWidth / 3) - 20 // 10 padding
        let btnHeight = btnWidth
        
        btn.frame.size = CGSize(width: btnWidth, height: btnHeight)
        
        print("after assigned -> \(btn.frame.size.height)")
        
    }
    

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
