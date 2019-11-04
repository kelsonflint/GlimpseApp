//
//  GlobalMediaController.swift
//  GlimpseApp
//
//  Created by Kelson Flint on 5/15/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import MobilePlayer


class GlobalMediaController : UITableViewController {
    
    var videos = [Video]()
    var eventId : Int!
    var eventName: String?
    var eventData : thisEvent?
    var userId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMedia()
        setupNavBar()
        tableView.backgroundColor = FlatSkyBlue()
        self.navigationController?.navigationBar.tintColor  = .white
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cellId")
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
        navigationLauncher.userId = self.userId
        navigationLauncher.showSettings()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! VideoCell
        let video = videos[videos.count - indexPath.row - 1]
        cell.video = video
        let videoURL = URL(string: video.link!)
        let thumbnailImage = videoURL!.createVideoThumbnail()
        cell.thumbnailImageView.image = thumbnailImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let selectedVideo = videos[videos.count - 1 - indexPath.row]
        //let selectedVideo = videos[indexPath.row]
        let type = selectedVideo.link!.suffix(3)
        if (type == "mp4") {
            //let videoController = VideoController()
            //videoController.videoLink = selectedVideo.link
            //self.navigationController?.pushViewController(videoController, animated: true)
            let playerVC = MobilePlayerViewController(contentURL: URL(string: selectedVideo.link!)!)
            playerVC.title = "\(eventName!) - \(selectedVideo.dateTime)"
            playerVC.activityItems = [URL(string: selectedVideo.link!)!] // Check the documentation for more information.
            presentMoviePlayerViewControllerAnimated(playerVC)
        } else {
            print("tapped on picture")
        }
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
}
