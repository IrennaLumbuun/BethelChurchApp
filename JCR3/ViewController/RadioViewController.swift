//
//  RadioViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 01/08/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import AVFoundation

class RadioViewController: UIViewController, AVAssetResourceLoaderDelegate {
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var radioNameLbl: UILabel!
    @IBOutlet weak var onAirStatus: UILabel!
    @IBOutlet weak var numListenerLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    //global var
    var url = ""
    var img = ""
    var radioName = ""
    
    var player: AVPlayer!
    var avAudioSession:AVAudioSession = AVAudioSession.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlFile = URL(string: url)!
        self.radioImg.image = UIImage.init(named: img)
        self.radioNameLbl.text = "Radio" + radioName
        
        //autoplay radio
        try! avAudioSession.setCategory(.playback, mode: .default, options: [])
        try! avAudioSession.setActive(true)
        let audioURLAsset = AVURLAsset(url: urlFile)
        player = AVPlayer(playerItem: AVPlayerItem(asset: audioURLAsset))
        player.play()
    }
    
    //TODO: test this when connection is working
    @IBAction func shareBtnTapped(_ sender: Any) {
        let desc = "Shalom On Fire! Ayo dengerin \(radioName) dan download aplikasinya! Tuhan Yesus memberkati!"
        Utilities.displayShareController(message: desc, sender: self.shareBtn, viewController: self)
        // todo later
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        if player.rate != 0 {
            player.pause()
            onAirStatus.text = "Off Air"
            playBtn.setImage(UIImage(systemName: "play.circle"), for: .normal)
            onAirStatus.textColor = UIColor.red
        } else {
            player.play()
            playBtn.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            onAirStatus.text = "On Air"
            onAirStatus.textColor = UIColor.green
        }
    }
    
    @IBAction func chatBtnTapped(_ sender: Any) {
    }
}
