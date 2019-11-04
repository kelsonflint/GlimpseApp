//
//  MediaCollectionView.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/3/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class MediaCollectionView: UIViewController {
    
    
    
    var galleryCollectionView: UICollectionView!
    var featuredCollectionView: UICollectionView!
    var gallery : GalleryCollectionView!
    var featured : FeaturedCollectionView!
    var userId : String!
    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = eventName
        
        //setupFeatured()
        //setupCollectionView()
        setupNav()
        setupGallery()
        
    }
    
    func setupFeatured() {
        self.featured = FeaturedCollectionView(frame: .zero)
        self.featuredCollectionView = featured.collectionView
        self.featuredCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(featuredCollectionView)
        
    }
    
    func setupNav() {
        let navTitle = UILabel(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width - 32, height:70))
        navTitle.text = eventName
        navTitle.textColor = UIColor.red
        navTitle.font = UIFont.boldSystemFont(ofSize: 35)
        navigationItem.titleView = navTitle
    }
    
    func setupGallery() {
        self.gallery = GalleryCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        gallery.eventId = self.eventId
        gallery.userId = self.userId
        gallery.videos = self.videos
        self.galleryCollectionView = gallery.collectionView
        self.galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(galleryCollectionView)
    }
}


class FeaturedCollectionView : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var userId : String!
    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.backgroundColor = UIColor.green
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        
        let colors: [UIColor] = [.blue, .green, .gray, .purple]
        
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
}







