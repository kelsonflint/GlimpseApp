//
//  TestController.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 3/4/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit

class TestController : UIViewController {
    
    var userId : String!
    var videos = [Video]() //array of media data
    var eventId : Int!
    var eventName: String?
    
    //var featuredView = FeaturedController(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
    //var featuredView = FeaturedController()
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        // edit properties here
        _flowLayout.itemSize = CGSize(width: 98, height: 134)
        _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        _flowLayout.minimumInteritemSpacing = 0.0
        // edit properties here
        
        return _flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    
}
