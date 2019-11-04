//
//  SpecificEvent.swift
//  GlimpseApp
//
//  Created by Kelson Flint on 5/14/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit

struct SpecificEventJson : Decodable {
    let thisEventContent : UserEventVideos!
    let thisEvent : thisEvent!
}


struct thisEvent : Decodable {
    let startDate : String?
    let lat : String?
    let name : String?
    let num : Int?
    let createdAt : String?
    let headerImage : String?
    let long : String?
    let address : String?
    let endDate : String?
    let id : Int?
    let eventId : Int?
    let updatedAt : String?
}
