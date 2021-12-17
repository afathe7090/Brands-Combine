//
//  BrandsPhoneDetailsModel.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//


import Foundation

// MARK: - BrandsDetails
struct BrandsPhone: Codable  {
    let status: Bool?
    let data: BrandsPhoneDetails
}

// MARK: - DataClass
struct BrandsPhoneDetails: Codable  {
    let brand, phone_name: String?
    let thumbnail: String?
    let phone_images: [String]
    let release_date, dimension, os, storage: String?
    let specifications: [Specification]?
}

// MARK: - Specification
struct Specification: Codable {
    let title: String?
    let specs: [Spec]?
}

// MARK: - Spec
struct Spec: Codable {
    let key: String?
    let val: [String]?
}
