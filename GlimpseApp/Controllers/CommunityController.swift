//
//  EventController.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 1/29/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework


class CommunityController : UITableViewController {
    
    var userId : String?
    var events = [Event]() //array of media data
    var meta = [Meta]() //meta data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Events"
        
        fetchMedia()
        tableView.backgroundColor = FlatSkyBlue()
        tableView.rowHeight = UITableView.automaticDimension
        self.navigationController?.navigationBar.tintColor  = .white
        tableView.register(EventCell.self, forCellReuseIdentifier: "cellId")
        setupNavBar()
        
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = FlatSkyBlueDark()
        self.navigationController?.navigationBar.tintColor  = .white
        navigationItem.title = "Community Events"
        let moreButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItem = moreButton
        //let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(handleSearch))
        //navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    let navigationLauncher = NavigationLauncher()
    
    @objc func handleMore() {
        navigationLauncher.showSettings()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        cell.name.text = event.name
        cell.date.text = event.startDate
        cell.backgroundColor = FlatSkyBlue()
        //cell.textLabel?.text = event.name
        //cell.detailTextLabel?.text = event.startDate
        let url = URL(string: (event.headerImage)!)
        cell.thumbnailImageView.image = nil
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 9 / 16 + 40
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = events[indexPath.row]
        let destinationView = GlobalMediaController()
        
        destinationView.eventId = indexPath.row + 1
        destinationView.eventName = selectedEvent.name!
        destinationView.userId = userId
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    fileprivate func fetchMedia() {
        let urlString = "https://api.glimpsewearables.com/api/event/"
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
                let json = try decoder.decode(EventJson.self, from: data)
                self.meta = [json.meta!]
                self.events = json.objects!
                self.tableView.reloadData()
            } catch let jsonErr {
                print("Failed to decode: ", jsonErr)
            }
            print(self.meta)
            print(self.events)
            print(self.events.count)
            print("Parsed Events Properly")
            }.resume()
    }
}
