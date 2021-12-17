//
//  BrandsDetailsViewModel.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 15/12/2021.
//

import Combine
import CombineCocoa
import Foundation


protocol BrandsDetailsViewModelProtocol {
    var brandsDetails: [Phone] {get}
    var brand: BrandsData? {get}
    var brandsDetailsPublished: Published<[Phone]>.Publisher {get}
    func fetchBrandsDetailsData()
}


class BrandsDetailsViewModel:  BrandsDetailsViewModelProtocol{
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    var apiManager: ApiManagerProtocol!
    
    @Published var brandsDetails: [Phone] = []
    var brandsDetailsPublished: Published<[Phone]>.Publisher {$brandsDetails}
    var brand: BrandsData?
    
    var subscribation = Set<AnyCancellable>()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
   
    
    init(apiManager: ApiManagerProtocol = APiManager(), brand: BrandsData? = nil){
        self.apiManager = apiManager
        self.brand = brand
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func fetchBrandsDetailsData(){
        
        let url = brand?.detail ?? ""
        
        print(url)
        apiManager.fetch(BrandsDetails.self, withURL: url, receiveCompletion: { completion in
            
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished :
                print("Done")
            }
            
        }, receiveValue: { brands in
            print(brands)
            self.brandsDetails = brands.data.phones
        }, subscripation: &subscribation)
    }
    
    
}
