//
//  VideoCell.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 1/28/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import UIKit
import Foundation
import AVKit


class VideoCell: UITableViewCell {
    
    
    var video: Video?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        //setupThumbnail()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let date: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    func setupThumbnail() {
        let videoURL = URL(string: (video?.link)!)
        let thumbnailImage = videoURL!.createVideoThumbnail()
        thumbnailImageView.image = thumbnailImage
    }
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(date)

        NSLayoutConstraint.activate([
            thumbnailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 9 / 16),
            
            date.leftAnchor.constraint(equalTo: leftAnchor),
            date.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // get thumbnail from video url
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
     }

}
