//
//  ChannelRadioViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit

class ChannelRadioViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func HarpazoBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "HarpazoRadio", sender: self)
    }
    
    @IBAction func HMMinistryBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "HMMRadio", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RadioViewController
        if segue.identifier == "HarpazoRadio"{
            vc.url = "http://pu.klikhost.com:8060/stream"
            vc.img = "harpazo.jpg"
        }
        else if segue.identifier == "HMMRadio" {
            vc.url = "http://pu.klikhost.com:8060/stream"
            vc.img = "hmm.jpg"
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
