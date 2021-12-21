//
//  PhoneDetailsViewModel.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 17/12/2021.
//

import Foundation
import Combine

protocol PhoneDetailsViewModelProtocol {
    var isLoading: Bool {get}
    var isLoadingPublisher: Published<Bool>.Publisher {get}
    var phonePublisher: Published<BrandsPhoneDetails?>.Publisher {get}
    var imagePublisher: Published<[String]>.Publisher { get }
    
    func fetchPhoneData()
    
}



class PhoneDetailsViewModel: PhoneDetailsViewModelProtocol{
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Published
    //----------------------------------------------------------------------------------------------------------------
    @Published var isLoading: Bool = false
    var isLoadingPublisher: Published<Bool>.Publisher{$isLoading}
    
    @Published var phone: BrandsPhoneDetails?
    var phonePublisher: Published<BrandsPhoneDetails?>.Publisher {$phone}
    @Published var phoneData: Phone?
    
    @Published var images = [String]()
    var imagePublisher: Published<[String]>.Publisher {$images}
    
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Manager
    //----------------------------------------------------------------------------------------------------------------
    var subscribation = Set<AnyCancellable>()
    var apiManager: ApiManagerProtocol!
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Variable
    //----------------------------------------------------------------------------------------------------------------
    
    
    init(_ apiManager: ApiManagerProtocol = APiManager(), phoneData: Phone? = nil){
        self.apiManager = apiManager
        self.phoneData = phoneData
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func fetchPhoneData() {
        guard let url = phoneData?.detail else{return}
        apiManager.fetch(BrandsPhone.self
                         , withURL: url, receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print( error.localizedDescription)
                
            case .finished:
                print("Done")
            }
            
        }, receiveValue: { phone in
            self.phone = phone.data
            self.images = phone.data.phone_images
        }, subscripation: &subscribation)
    }
    
    
}
