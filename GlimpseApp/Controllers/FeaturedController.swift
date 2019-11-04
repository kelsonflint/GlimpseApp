//
//  FeaturedController.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/4/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit

class FeaturedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //var collectionView: UICollectionView!
    var galleryView: UICollectionView!
    var userId : String!
    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeaturedView()
        setupGallery()
    }
    
    func setupGallery() {
        print("fuck")
        print(eventId!)
//        let galleryView : GalleryCollectionView = {
//            let layout = UICollectionViewFlowLayout()
//            let cv = GalleryCollectionView(frame: .zero, collectionViewLayout: layout, eventId: self.eventId, userId: self.userId)
//            cv.backgroundColor = UIColor.white
//            return cv
//        }()
        galleryView = GalleryCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout(), eventId: self.eventId, userId: self.userId)
        view.addSubview(galleryView)
        galleryView.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 350)
//        if let window = UIApplication.shared.keyWindow {
//            window.addSubview(galleryView)
//            galleryView.frame = CGRect(x: 0, y: 350, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 350)
//        }
        
    }
    
    func setupFeaturedView() {
//        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500), collectionViewLayout: UICollectionViewLayout())
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.white
        
        //        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(FeaturedCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
        //self.view.addSubview(collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! FeaturedCell
        cell.thumbnailImageView.backgroundColor = UIColor.black
        let colors: [UIColor] = [.blue, .green, .gray, .purple]

        cell.backgroundColor = colors[indexPath.item]

        return cell
    }
    
    
    
}
