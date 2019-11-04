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

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchMedia()
        navigationItem.title = eventName
        collectionView.backgroundColor = UIColor.white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
    }
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? VideoCell
        cell?.video = videos[indexPath.item]
        cell?.backgroundColor = UIColor.blue
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: screenSize.width, height: 200)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath)
    {
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor.red
        print("User tapped on item \(indexPath.row)")
    }

    
    fileprivate func fetchMedia() {
        let id: String = String(eventId)
        let urlString = "https://api.glimpsewearables.com/media/getAllVideosUserEvent/1/\(id)"
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
}


