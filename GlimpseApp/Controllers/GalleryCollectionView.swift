//
//  GalleryCollectionView.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/5/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class GalleryCollectionView : UICollectionView {
    
    var collectionView : UICollectionView!
    var userId : String!
    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?
    //var navController : UINavigationController
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, eventId: Int, userId: String) {
        self.init(frame: frame, collectionViewLayout: layout)
        self.eventId = eventId
        self.userId = userId
        //self.navController = nav
        fetchMedia()
        setupCollectionView()
        reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: UICollectionViewLayout())
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(GalleryCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.backgroundColor = .red
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),//, constant: 300),
            collectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            //collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 300)
            ])
        
    }
    

    
    fileprivate func fetchMedia() {
        let id: String = String(eventId!)
        let urlString = "https://api.glimpsewearables.com/media/getAllVideosUserEvent/\(userId!)/\(id)"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            /*
             guard let path = Bundle.main.path(forResource: "user1event1", ofType: "json") else { return }
             let url = URL(fileURLWithPath: path)
             URLSession.shared.dataTask(with: url) { (data, _, err) in
             */
            if let err = err {
                print("failed to get data from url", err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode(VideoJson.self, from: data)
                let userEvent = json.userEventVideos
                self.videos = userEvent.rawMedia!
                self.collectionView.reloadData()
            } catch let jsonErr {
                print("Failed to decode: ", jsonErr)
            }
            //print(self.videos)
            print(self.videos.count)
            print("Parsed Media Properly")
            }.resume()
    }
    
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

extension GalleryCollectionView:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
        let video = videos[indexPath.row]
        cell.thumbnailImageView.image = getThumbnailImage(forUrl: URL(string: video.link!)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let selectedVideo = videos[indexPath.row]
        //let videoController = VideoController()
        //videoController.videoLink = selectedVideo.link
        //self.navigationController?.pushViewController(videoController, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.bounds.width - padding
        
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize/2 * 9 / 16)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5
        )
    }
}
