//
//  UserEvent.swift
//  GlimpseApp
//
//  Created by Kelson Flint on 4/25/19.
//  Copyright © 2019 Kelson Flint. All rights reserved.
//
//{
//    "start_date": "2018-08-31",
//    "lat": "47.606",
//    "name": "Bumbershoot Festival",
//    "num_videos": 9,
//    "created_at": "2019-02-23 01:40:52.107994+00:00",
//    "header_image": "https://s3-us-west-2.amazonaws.com/users-edited-content/headerImages/event2_header_BumbershootFestival.jpg",
//    "long": "122.332",
//    "address": "Seattle City Center",
//    "end_date": "2018-09-03",
//    "id": 2,
//    "event_id": 2,
//    "updated_at": "2019-02-23 01:40:52.108029+00:00"
//},

//"user_id": 1,
//"user_name": "glimpseTesting",
//"phone": "5094818244",
//"password": "password",
//"profile_pic_link": "",
//"first_name": "glimpse",
//"last_name": "project",
//"created_at": "2019-02-23 01:40:52.048884+00:00",
//"email": "drose@glimpsewearables.com",
//"updated_at": "2019-02-23 01:40:52.048918+00:00"

import Foundation
import UIKit

struct UserEventJson : Decodable {
    let events : AllEvents!
    let user : User!
}

struct AllEvents : Decodable {
    let allEvents : [UserEvent]!
}

struct UserEvent : Decodable {
    let startDate : String?
    let lat : String?
    let name : String?
    let numVideos : Int?
    let createdAt : String?
    let headerImage : String?
    let long : String?
    let address : String?
    let endDate : String?
    let id : Int?
    let eventId : Int?
    let updatedAt : String?
}

struct User : Decodable {
    let userId : Int?
    let userName : String?
    let phone : String?
    let password : String?
    let profilePicLink : String?
    let firstName : String?
    let lastName : String?
    let createdAt : String?
    let email : String?
    let updatedAt : String?
}
