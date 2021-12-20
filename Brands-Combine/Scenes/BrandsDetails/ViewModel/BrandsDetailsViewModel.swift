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
    var isLoading: Bool {get}
    var brandsDetailsPublished: Published<[Phone]>.Publisher {get}
    var isLoadingPublisher: Published<Bool>.Publisher {get}
    var delegate: PhoneDataProtocol? {get set}
    
    func fetchBrandsDetailsData()
    func sendPhone(_ index: Int)
}



protocol DataBrandsCommingProtocol: AnyObject{
    func getBrand(_ brand: BrandsData)
}



class BrandsDetailsViewModel:  BrandsDetailsViewModelProtocol{
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    var apiManager: ApiManagerProtocol {
        return APiManager()
    }
    
    @Published var brandsDetails: [Phone] = []
    var brandsDetailsPublished: Published<[Phone]>.Publisher {$brandsDetails}
    
    @Published var isLoading: Bool = false
    var isLoadingPublisher: Published<Bool>.Publisher {$isLoading}
    
    @Published var brand: BrandsData?
    var subscribation = Set<AnyCancellable>()
    
    weak var delegate: PhoneDataProtocol?
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
   
    
    init(){}
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func fetchBrandsDetailsData(){
        
        let url = brand?.detail ?? ""
        
        isLoading = true
        apiManager.fetch(BrandsDetails.self, withURL: url, receiveCompletion: { completion in
            
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished :
                self.isLoading = false
                print("Done")            }
            
        }, receiveValue: { brands in
            self.brandsDetails = brands.data.phones
        }, subscripation: &subscribation)
    }
    
    
    func sendPhone(_ index: Int){
        delegate?.getPhone(brandsDetails[index])
    }
    
    
}

extension BrandsDetailsViewModel: DataBrandsCommingProtocol{
    func getBrand(_ brand: BrandsData) {
        self.brand = brand
    }
}
