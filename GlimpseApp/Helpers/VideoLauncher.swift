//
//  VideoLauncher.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 1/28/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class VideoPlayerView: UIView {
    var videoLink: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(videoLink!)
        backgroundColor = UIColor.black
        
        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
        if let url = URL(string: self.videoLink!) {
            let player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    var link: String?
    
    func showVideoPlayer() {
        print("Showing video player animation....")
        print(link!)
        
        
        /*
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            //16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            videoPlayerView.videoLink = link
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                //maybe we'll do something here later...
                //UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
 */
 
    }
}

