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
    
    var player: AVPlayer!
    var avAudioSession:AVAudioSession = AVAudioSession.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        let urlFile = URL(string: url)!
        self.radioImg.image = UIImage.init(named: img)
        
        //autoplay radio
        try! avAudioSession.setCategory(.playback, mode: .default, options: [])
        try! avAudioSession.setActive(true)
        let audioURLAsset = AVURLAsset(url: urlFile)
        player = AVPlayer(playerItem: AVPlayerItem(asset: audioURLAsset))
        player.play()
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        // todo later
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        print(player.rate)
        if player.rate != 0 {
            player.pause()
            onAirStatus.text = "Not Playing"
            playBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
                player.play()
                playBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
                onAirStatus.text = "Playing"
        }
    }
    
    @IBAction func chatBtnTapped(_ sender: Any) {
    }
}
