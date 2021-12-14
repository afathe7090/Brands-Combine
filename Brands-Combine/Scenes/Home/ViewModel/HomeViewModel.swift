//
//  HomeViewModel.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 14/12/2021.
//

import Foundation
import Combine


protocol HomeViewModelProtocol: AnyObject {
    
    var brandsData: [BrandsData] {get}
    var brandsDataPublisher: Published<[BrandsData]>.Publisher {get}
    
    var isLoading: Bool {get}
    var isLoadingBublisher: Published<Bool>.Publisher {get}
    
    func fetchBrandsOfData()
}



class HomeViewModel: HomeViewModelProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Combine variables
    //----------------------------------------------------------------------------------------------------------------
    
    @Published var brandsData: [BrandsData] = []
    var brandsDataPublisher: Published<[BrandsData]>.Publisher{$brandsData}

    @Published var isLoading: Bool = false
    var isLoadingBublisher: Published<Bool>.Publisher{ $isLoading }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    var subscripation = Set<AnyCancellable>()
    var apiDelegate: ApiManagerProtocol?
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(apiDelegate: ApiManagerProtocol = APiManager()){
        self.apiDelegate = apiDelegate
    }
    
        
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Function
    //----------------------------------------------------------------------------------------------------------------
    
    func fetchBrandsOfData(){
        isLoading = true
        
        apiDelegate?.fetch(Brands.self, withURL: BRANDS_URL, receiveCompletion: { completion in
            switch completion {
            case .failure(let fail):
                print(fail.localizedDescription)
                self.isLoading = false
            case .finished:
                print("done")
            }
                        
        }, receiveValue: { brands in
            self.isLoading = false
            self.brandsData = brands.data
        }, subscripation: &subscripation)
    }
    
    
}
