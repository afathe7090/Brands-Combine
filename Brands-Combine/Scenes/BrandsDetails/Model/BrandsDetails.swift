//
//  File.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import Foundation

// MARK: - BrandsDetails
struct BrandsDetails: Codable {
    let status: Bool?
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let title: String
    let current_page, last_page: Int
    let phones: [Phone]
}

// MARK: - Phone
struct Phone: Codable {
    let brand: String
    let phone_name, slug: String
    let image: String
    let detail: String
}
