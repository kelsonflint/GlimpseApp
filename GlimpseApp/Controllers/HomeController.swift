//
//  HomeController.swift
//
//  Created by Kelson Flint on 1/29/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework


class HomeController : UITableViewController {
    
    var userId : String?
    var allEvents = [UserEvent]()
    var loadedEvents = [UserEvent]()
    var user : User!
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMedia()
        setupNavBar()
        tableView.backgroundColor = FlatSkyBlue()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EventCell.self, forCellReuseIdentifier: "cellId")
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = FlatSkyBlueDark()
        self.navigationController?.navigationBar.tintColor  = .white
        navigationItem.title = "Your Events"
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

    
    
    @objc func handleSearch() {
        
    }
    
    
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return loadedEvents.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! EventCell
            let event = loadedEvents[indexPath.row]
            cell.event = event
            cell.name.text = event.name
            cell.date.text = event.startDate
            cell.backgroundColor = FlatSkyBlue()
            cell.count.text = "\(String(event.numVideos!)) videos"
            cell.setupThumbnail()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 9 / 16 + 40
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = loadedEvents[indexPath.row]
        //let destinationView = MediaController()
        let destinationView = YourMediaController()
        
        destinationView.eventId = selectedEvent.eventId
        destinationView.eventName = selectedEvent.name!
        destinationView.userId = userId
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        self.fetchingMore = true
        print("Being batch fetch!")
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        let loaded = self.loadedEvents.count
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            for i in loaded...loaded + 10 {
                self.loadedEvents.append(self.allEvents[i])
            }
            self.fetchingMore = false
            self.tableView.reloadData()
        })
    }
    
    fileprivate func fetchMedia() {
        let urlString = "https://api.glimpsewearables.com/media/getSpecificUser/\(userId!)"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            /*
             guard let path = Bundle.main.path(forResource: "events", ofType: "json") else { return }
             let url = URL(fileURLWithPath: path)
             URLSession.shared.dataTask(with: url) { (data, _, err) in */
            if let err = err {
                print("failed to get data from url", err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode(UserEventJson.self, from: data)
                let allEvents = json.events!
                self.allEvents = allEvents.allEvents!
                self.user = json.user!
                for i in 0...9 {
                    self.loadedEvents.append(self.allEvents[i])
                }
                self.tableView.reloadData()
            } catch let jsonErr {
                print("Failed to decode: ", jsonErr)
            }
            print("\(self.allEvents.count) events")
            print("Parsed Events Properly")
            }.resume()
    }
}
