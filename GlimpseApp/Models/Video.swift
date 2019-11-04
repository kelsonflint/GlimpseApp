//
//  Video.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 1/27/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//
/*
 {
 "raw_or_edited": "raw",
 "date": "2018-11-17",
 "starred": 0,
 "user_id": "1",
 "views": 0,
 "event_id": "1",
 "downloaded": 0,
 "gif_link": "",
 "ranking": 1,
 "link": "https:\/\/s3-us-west-2.amazonaws.com\/users-raw-content\/09950_user1_video_2018-11-17_16.25.26.mp4",
 "device_id": "1",
 "date_time": "16.25.26",
 "media_type": "video",
 "created_at": "2019-02-10 22:13:46.454821+00:00",
 "updated_at": "2019-02-10 22:13:46.454899+00:00"
 }
 */

import Foundation
import UIKit

struct UserEventVideos: Decodable {
    let editedMedia: [Video]!
    let curatedMedia: [Video]!
    let featuredMedia: [Video]!
    let rawMedia: [Video]!
}

struct VideoJson: Decodable {
    let userEventVideos: UserEventVideos
}

class Video: Decodable {
    let views: Int?
    let rawOrEdited: String?
    let eventId: String?
    let gifLink: String?
    let ranking: Int?
    let deviceId: String?
    let dateTime: String?
    let link: String?
    let createdAt: String?
    let downloaded: Int?
    let date: String?
    let userId: String?
    let mediaType: String?
    let starred: Int?
    let updatedAt: String?
}

