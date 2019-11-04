//
//  NavigationLauncher.swift
//  GlimpseApp
//
//  Created by Kelson Flint on 5/12/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class NavigationLauncher : NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var userId : String?
    var window : UIWindow?
    
    let blackView = UIView()
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = FlatSkyBlueDark()
        return cv
    }()

    let settings: [Setting] = {
        return [Setting(name: "Account", imageName: "Profile"), Setting(name: "Home", imageName: "home"), Setting(name: "Community", imageName: "globe"), Setting(name: "Settings", imageName: "settings")]
    }()
    
    @objc func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settings.count) * 60
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x:0, y:y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! NavCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        DispatchQueue.main.async {
            if (setting.name == "Account") {
                
            } else if (setting.name == "Home") {
                let destinationView = HomeController()
                destinationView.userId = self.userId
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.makeKeyAndVisible()
                self.window?.rootViewController = UINavigationController(rootViewController: destinationView)
            } else if (setting.name == "Community") {
                let destinationView = CommunityController()
                destinationView.userId = self.userId
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.makeKeyAndVisible()
                self.window?.rootViewController = UINavigationController(rootViewController: destinationView)
            } else if (setting.name == "Settings") {
                
            }
        }
        
        
    }
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(NavCell.self, forCellWithReuseIdentifier: "cellId")
    }
}
