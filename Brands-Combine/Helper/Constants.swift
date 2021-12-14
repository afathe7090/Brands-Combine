//
//  Constants.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 14/12/2021.
//

import Foundation


let kUID = "uID"
let BASE_URL = "https://api-mobilespecs.azharimm.site/v2/"
let BRANDS_URL = BASE_URL + "brands"


func saveUser(uID: String?){
    UserDefaults.standard.set(uID, forKey: kUID)
    UserDefaults.standard.synchronize()
}


func returnUserId()-> String? {
    return UserDefaults.standard.string(forKey: kUID) as String?
}
