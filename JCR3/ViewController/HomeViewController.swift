//
//  HomeViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 23/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var newsUpdateSearchBar: UISearchBar!
    @IBOutlet weak var inboxUpdateBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var gemarBtn: UIButton!
    @IBOutlet weak var notifScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        setScrollableButttonGroup()
        
    }
    
    func setScrollableButttonGroup(){
        var scView:UIScrollView!
        let buttonPadding:CGFloat = 10
        var xOffset:CGFloat = 10
        
        scView = UIScrollView(frame: CGRect(x: 0, y: 300, width: view.bounds.width, height: 50))
        scView.isPagingEnabled = true
        view.addSubview(scView)

        scView.translatesAutoresizingMaskIntoConstraints = false
        
        let btnName: [String] = ["Live Streaming", "Warrior Bride", "SBS COOL", "Dukungan Doa"]

        for i in 0 ... 3 {
            let button = UIButton()
            button.tag = i
            button.setTitle("\(btnName[i])", for: .normal)
            button.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action: #selector(self.btnClicked), for: UIControl.Event.touchUpInside)
            
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: CGFloat(btnName[i].count * 10), height: 30)
            button.layer.cornerRadius = 10

            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
        }

        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
    }
    @objc func btnClicked(sender : UIButton) {
        //get buttonName
        let btnTag = sender.tag
        print(btnTag)
        // 0 -> pop up with link
        if btnTag == 0 {
            let popUp = storyboard?.instantiateViewController(identifier: Constants.Storyboard.liveStreamPopUp) as? StreamingPopUpViewController
            self.addChild(popUp!)
            popUp!.view.frame = self.view.frame
            self.view.addSubview(popUp!.view)
            popUp?.didMove(toParent: self)
            
        }
        // 1 -> auto download warrior bride
        // 2 -> open link
        // 3 -> redirect to dukunganDoa
    }
}
