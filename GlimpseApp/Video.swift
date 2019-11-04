//
//  Video.swift
//  youtubeTesting
//
//  Created by Kelson Flint on 1/27/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//

import Foundation
import UIKit

struct UserEventVideos: Decodable {
    let videos: [Video]!
}

struct Json: Decodable {
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

