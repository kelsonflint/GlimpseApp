//
//  FeaturedCell.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/4/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit

class FeaturedCell : UICollectionViewCell {
    
    var video: Video?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
//    let featuredCollectionView : UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        collectionView.backgroundColor = UIColor.black
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(dateTime)
        addSubview(rating)
        addSubview(playButton)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 32) * 9 / 16),
            thumbnailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - 32) * 9 / 16) / 2),
            playButton.widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - 32) * 9 / 16) / 2),
            
        ])
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
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
    
    let dateTime: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let rating: UILabel = {
        let rate = UILabel()
        rate.translatesAutoresizingMaskIntoConstraints = false
        return rate
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
