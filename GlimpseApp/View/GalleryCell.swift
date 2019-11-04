//
//  GalleryCell.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/3/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class GalleryCell: UICollectionViewCell {
    
    var video: Video?
    
   //static var identifier: String = "Cell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor.blue
        setupViews()
        //setupThumbnail()
    }
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(playButton)
        NSLayoutConstraint.activate([
            //thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            //thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            //thumbnailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: self.frame.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.height),
            playButton.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            playButton.widthAnchor.constraint(equalToConstant: self.frame.height / 2),

        ])
    }
    
//    func setupThumbnail() {
//        let videoURL = URL(string: (video?.link!)!)
//        let thumbnailImage = videoURL!.createVideoThumbnail()
//        thumbnailImageView.image = thumbnailImage
//    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let playButton : UIImageView = {
        let play = UIImageView()
        play.translatesAutoresizingMaskIntoConstraints = false
        play.image = UIImage(named: "playbutton")
        return play
    }()
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {

    }
}

