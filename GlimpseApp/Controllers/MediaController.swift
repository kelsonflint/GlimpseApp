//
//  ViewController.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 1/27/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MediaController: UITableViewController {
    
    var userId : String!
    var videos = [Video]() //array of media data
    var eventData : thisEvent?
    var eventId : Int!
    var eventName: String?
    var galleryView : UICollectionView!
    var thumbnails = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchMedia()
        //navigationItem.title = eventName
        let navTitle = UILabel(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width - 32, height:70))
        navTitle.text = eventName
        navTitle.textColor = UIColor.red
        navTitle.font = UIFont.boldSystemFont(ofSize: 35)
        navigationItem.titleView = navTitle
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cellId")
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
        configureHeaderView()
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! VideoCell
        let video = videos[indexPath.row]
        cell.date.text = "\(video.date!), \(video.dateTime!)"
        cell.thumbnailImageView.image = getThumbnailImage(forUrl: URL(string: video.link!)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let selectedVideo = videos[indexPath.row]
        let videoController = VideoController()
        videoController.videoLink = selectedVideo.link
        self.navigationController?.pushViewController(videoController, animated: true)
    }
    
    
    fileprivate func fetchMedia() {
        let id: String = String(eventId)
        let urlString = "https://api.glimpsewearables.com/media/getSpecificEvent/\(id)"
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
                let json = try decoder.decode(SpecificEventJson.self, from: data)
                let thisEvent = json.thisEventContent
                self.eventData = json.thisEvent
                self.videos = thisEvent!.rawMedia!
                self.tableView.reloadData()
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

extension MediaController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureHeaderView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let headerView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300), collectionViewLayout: layout)
        headerView.backgroundColor = .blue
        headerView.isPagingEnabled = true
        headerView.isUserInteractionEnabled = true
        
        headerView.dataSource = self
        headerView.delegate = self
        headerView.register(FeaturedCell.self, forCellWithReuseIdentifier: "cell")
        //headerView.showsHorizontalScrollIndicator = false
        
        tableView.tableHeaderView = headerView
    }
    
    // MARK: UICollectionViewDataSource
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! FeaturedCell
        cell.thumbnailImageView.backgroundColor = UIColor.black
        let colors: [UIColor] = [.blue, .green, .gray, .purple]
        
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
}
