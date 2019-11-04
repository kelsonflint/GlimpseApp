//
//  Event.swift
//  GlimpseBasic
//
//  Created by Kelson Flint on 1/29/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//
/*
 "address": "WaMu Theatre, 800 Occidental Ave S, Seattle, WA 98134",
 "created_at": "2019-01-25T12:20:31.267133",
 "end_date": "2018-12-01",
 "event_id": 3,
 "header_image": "https:\/\/s3-us-west-2.amazonaws.com\/users-edited-content\/headerImages\/event3_header_LouisTheChild.jpg",
 "id": 3,
 "lat": "47.595",
 "long": "-122.332",
 "name": "Louis The Child",
 "resource_uri": "\/api\/event\/3\/",
 "start_date": "2018-12-01",
 "start_time": "19:00:00",
 "updated_at": "2019-01-25T12:20:31.267254"
 */
import Foundation

struct EventJson: Decodable {
    let meta: Meta!
    let objects: [Event]!
}

struct Meta: Decodable {
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let totalCount: Int?
}

class Event: Decodable {
    let address: String?
    let createdAt: String!
    let endDate: String?
    let eventId: Int?
    let headerImage: String?
    let id: Int
    let lat: String?
    let long: String?
    let name: String?
    let resourceUri: String?
    let startDate: String?
    let startTime: String?
    let updatedAt: String?
}
