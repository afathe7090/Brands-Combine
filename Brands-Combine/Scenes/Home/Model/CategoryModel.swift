//
//  CategoryModel.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import Foundation

// MARK: - Brands
struct Brands: Codable {
    let status: Bool?
    let data: [BrandsData]
}

// MARK: - Datum
struct BrandsData: Codable {
    let brand_id: Int
    let brand_name, brand_slug: String
    let device_count: Int
    let detail: String
}

