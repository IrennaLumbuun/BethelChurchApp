//
//  ChannelRadioViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit

class ChannelRadioViewController: UIViewController {

    @IBOutlet weak var HarpazoBtn: UIButton!
    @IBOutlet weak var HMMBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleRectangularButton(btn: HarpazoBtn)
        Utilities.styleRectangularButton(btn: HMMBtn)
    }
    
    @IBAction func HarpazoBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "radio", sender: sender)
    }
    
    @IBAction func HMMinistryBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "radio", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "radio" {

            let senderButton = sender as! UIButton
            let vc = segue.destination as! RadioViewController
            
            switch senderButton{
            case HarpazoBtn:
                vc.url = "http://pu.klikhost.com:8060/stream"
                vc.img = "harpazo.jpg"
                vc.radioName = "Harpazo"
                
            case HMMBtn:
                //editing button scenario
                vc.url = "http://pu.klikhost.com:8060/stream"
                vc.img = "hmm.jpg"
                vc.radioName = "HMM"
            default:
                print("Radio error: unexpectedly triggered")
                print(senderButton)
            }

        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        //transition to home
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        homeVC?.modalPresentationStyle = .fullScreen
        homeVC?.modalTransitionStyle = .coverVertical
        present(homeVC!, animated: true, completion: nil)
    }
}
