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
    
    var phone: BrandsPhoneDetails? {get}
    var phonePublisher: Published<BrandsPhoneDetails?>.Publisher {get}
    
    var imagesPublisher: AnyPublisher<[String],Never> {get}
    
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
    
    var phoneData: Phone?
    
    var imagesPublisher: AnyPublisher<[String],Never> {
        return phonePublisher.map { brand in
            return brand?.phone_images ?? [""]
        }.eraseToAnyPublisher()
    }
        
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Variable
    //----------------------------------------------------------------------------------------------------------------
    
    
    init(phone: Phone? = nil){
        self.phoneData = phone
    }
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Manager
    //----------------------------------------------------------------------------------------------------------------
    var subscribation = Set<AnyCancellable>()
    var apiManager: ApiManagerProtocol {
        return APiManager()
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
            print(phone)
        }, subscripation: &subscribation)
    }
    
    
}
