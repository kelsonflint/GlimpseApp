//
//  VideoController.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 2/1/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class VideoController : UIViewController {
    
    var videoLink : String?
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let videoURL = URL(string: videoLink!)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
 */
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let videoURL = URL(string: videoLink!)
        //let player = AVPlayer(url: videoURL!)
        let playerItem:AVPlayerItem = AVPlayerItem(url: videoURL!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion:CGFloat = 100
        let yPostion:CGFloat = 230
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        playButton!.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControl.State.normal)
        playButton!.tintColor = UIColor.black
        //playButton!.addTarget(self, action: Selector("playButtonTapped:"), for: .touchUpInside)
        playButton!.addTarget(self, action: #selector(VideoController.playButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
    }
        
        // Add playback slider
//
//        let playbackSlider = UISlider(frame:CGRect(x: 30, y:200, width:300, height:20))
//        playbackSlider.minimumValue = 0
//
//
//        let duration : CMTime = playerItem.asset.duration
//        let seconds : Float64 = CMTimeGetSeconds(duration)
//
//        playbackSlider.maximumValue = Float(seconds)
//        playbackSlider.isContinuous = true
//        playbackSlider.tintColor = UIColor.green
//
//        playbackSlider.addTarget(self, action: #selector(VideoController.playbackSliderValueChanged(_:)), for: .valueChanged)
//        // playbackSlider.addTarget(self, action: "playbackSliderValueChanged:", forControlEvents: .ValueChanged)
//        self.view.addSubview(playbackSlider)
//
//    }
//
//    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
//    {
//
//        let seconds : Int64 = Int64(playbackSlider.value)
//        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
//
//        player!.seek(to: targetTime)
//
//        if player!.rate == 0
//        {
//            player?.play()
//        }
//    }
//
    
    @objc func playButtonTapped(_ sender:UIButton) {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Pause", for: UIControl.State.normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Play", for: UIControl.State.normal)
        }
    }
}
