//
//  YourMediaController.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/22/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import ChameleonFramework
import MobilePlayer


class YourMediaController : UIViewController {
    
    var userId : String!
    var featuredContent = [Video]()
    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?
    var galleryView : UICollectionView!
    var featuredView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMedia()
        setupNavBar()
        configureHeaderView()
        setupGallery()
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = FlatSkyBlueDark()
        self.navigationController?.navigationBar.tintColor  = .white
        navigationItem.title = eventName
        let moreButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItem = moreButton
        //let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(handleSearch))
        //navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    let navigationLauncher = NavigationLauncher()
    
    @objc func handleMore() {
        navigationLauncher.showSettings()
    }
    
    func setupGallery() {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        //galleryView = GalleryCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout, eventId: self.eventId, userId: self.userId)
        galleryView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        self.galleryView?.dataSource = self
        self.galleryView?.delegate = self
        self.galleryView?.register(GalleryCell.self, forCellWithReuseIdentifier: "cell")
        self.galleryView.backgroundColor = FlatSkyBlue()
        view.addSubview(galleryView)
    }
    
    func configureHeaderView() {
        if (featuredContent.count != 0) { //CHANGE for actual functionality
            let headerContainer = UIView(frame: CGRect(x: 0, y: -300, width: galleryView.frame.width, height: 300))
            
            let momentLabel = UILabel(frame: CGRect(x: -3, y: 257, width: view.frame.width + 6, height: 40))
            momentLabel.text = "  Your Moments"
            momentLabel.textColor = UIColor.white
            momentLabel.backgroundColor = FlatGreenDark()
            momentLabel.font = UIFont.boldSystemFont(ofSize: 25)
            //momentLabel.layer.borderWidth = 2.0
            headerContainer.addSubview(momentLabel)
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            featuredView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260), collectionViewLayout: layout)
            featuredView.backgroundColor = .white
            featuredView.isPagingEnabled = true
            featuredView.isUserInteractionEnabled = true
            
            featuredView.dataSource = self
            featuredView.delegate = self
            featuredView.register(FeaturedCell.self, forCellWithReuseIdentifier: "cell")
            headerContainer.addSubview(featuredView)
            
            //featuredView.showsHorizontalScrollIndicator = false
            galleryView.addSubview(headerContainer)
            galleryView.contentInset.top = 300
        } else {
            let momentLabel = UILabel(frame: CGRect(x: -3, y: -40, width: view.frame.width + 6, height: 40))
            momentLabel.text = "  Your Moments"
            momentLabel.textColor = .white
            momentLabel.font = UIFont.boldSystemFont(ofSize: 25)
            momentLabel.backgroundColor = FlatGreenDark()
            //momentLabel.layer.borderWidth = 2.0
            //galleryView.addSubview(momentLabel)
            //galleryView.contentInset.top = 40
        }
    }
    
}



extension YourMediaController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == featuredView) {
            //return featured.count
            return 4
        } else {
            return videos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  (collectionView == featuredView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! FeaturedCell
            //let video = videos[videos.count - 1 - indexPath.item]
            cell.thumbnailImageView.backgroundColor = UIColor.black
            //cell.thumbnailImageView.image = getThumbnailImage(forUrl: URL(string: video.link!)!)
            //let colors: [UIColor] = [.blue, .green, .gray, .purple]
            //cell.backgroundColor = colors[indexPath.item]
            cell.backgroundColor = FlatGreen()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
            //let video = videos[videos.count - 1 - indexPath.row]
            let video = videos[indexPath.item]
            cell.video = video
            let videoURL = URL(string: video.link!)
            let thumbnailImage = videoURL!.createVideoThumbnail()
            cell.thumbnailImageView.image = thumbnailImage
            //cell.thumbnailImageView.image = getThumbnailImage(forUrl: URL(string: video.link!)!)
//            let type = video.link!.suffix(3)
//            if (type == "mp4") {
//                cell.thumbnailImageView.image = getThumbnailImage(forUrl: URL(string: video.link!)!)
//            } else {
//                let url = URL(string: video.link!)
//                do {
//                    let data = try Data(contentsOf: url!)
//                    let image = UIImage(data: data)
//                    cell.thumbnailImageView.image = image
//                }catch let err {
//                    print("Error : \(err.localizedDescription)")
//                }
//            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == featuredView) {
            
        } else {
            print("User tapped on item \(indexPath.row)")
            //let selectedVideo = videos[videos.count - 1 - indexPath.row]
            let selectedVideo = videos[indexPath.row]
            let type = selectedVideo.link!.suffix(3)
            if (type == "mp4") {
            //let videoController = VideoController()
            //videoController.videoLink = selectedVideo.link
            //self.navigationController?.pushViewController(videoController, animated: true)
            let playerVC = MobilePlayerViewController(contentURL: URL(string: selectedVideo.link!)!)
            playerVC.title = "\(eventName) - \(selectedVideo.dateTime)"
            playerVC.activityItems = [URL(string: selectedVideo.link!)!] // Check the documentation for more information.
            presentMoviePlayerViewControllerAnimated(playerVC)
            } else {
                print("tapped on picture")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == featuredView) {
            return CGSize(width: UIScreen.main.bounds.width, height: 260)
        } else {
            let padding: CGFloat =  40
            let collectionViewSize = collectionView.bounds.width - padding
            
            return CGSize(width: collectionViewSize / 2, height: collectionViewSize/2 * 9 / 16)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (collectionView == featuredView) {
            return 0
        } else {
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if (collectionView == featuredView) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 12.5, left: 12.5, bottom: 0, right: 12.5)
        }
    }
    
    
    
    
    fileprivate func fetchMedia() {
        let id: String = String(eventId)
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
                self.featuredContent = userEvent.featuredMedia!
                self.videos = userEvent.rawMedia!
                self.galleryView.reloadData()
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
            //var thumbnailImage = CustomImageView()
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
            
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
}
