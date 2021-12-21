//
//  APiManager.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 14/12/2021.
//

import Foundation
import Combine

protocol ApiManagerProtocol {
    func fetch<T: Codable>(_ model: T.Type, withURL: String
                           , receiveCompletion: @escaping((Subscribers.Completion<Error>)-> Void) ,
                           receiveValue: @escaping(T)-> Void , subscripation: inout Set<AnyCancellable>)
}

class APiManager: ApiManagerProtocol {
    
    
    
    func fetch<T: Codable>(_ model: T.Type, withURL: String
                           ,receiveCompletion: @escaping((Subscribers.Completion<Error>)-> Void) ,
                           receiveValue: @escaping(T)-> Void ,
                           subscripation: inout Set<AnyCancellable>){
        
        guard !withURL.isEmpty else{return}
        NetworkManager.shared.getResults(model, urlStr: withURL)
            .receive(on: DispatchQueue.main)
            .map {$0}
            .sink(receiveCompletion: receiveCompletion, receiveValue: { T in
                receiveValue(T)
            })
            .store(in: &subscripation)
            
    }
    
}
