//
//  LoginViewModel.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 12/12/2021.
//

import Foundation
import Combine


protocol LoginViewModelProtocol{
    
    var textEmailSubject: CurrentValueSubject<String ,Never> { get set }
    var textPasswordSubject: CurrentValueSubject<String ,Never> { get set }
    var isLoading: Bool {get set}
    var isLoadingPublisher: Published<Bool>.Publisher {get}
    
    func checkEmailValidPublisher()-> AnyPublisher<Bool, Never>
    func checkPasswordValidPublisher()-> AnyPublisher<Bool,Never>
    func combineTwoValidPublisher()-> AnyPublisher<Bool, Never>
    
    func signInFirebase()
}


class LoginViewModel: LoginViewModelProtocol {
   
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    @Published var isLoading: Bool = false
    var isLoadingPublisher: Published<Bool>.Publisher {$isLoading}
    
    var textEmailSubject: CurrentValueSubject<String, Never> = CurrentValueSubject<String,Never>("")
    var textPasswordSubject: CurrentValueSubject<String, Never> = CurrentValueSubject<String,Never>("")
    
    var subscripation = Set<AnyCancellable>()
    var firebaseAuth: FirebaseAuthProtocol?
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  init
    //----------------------------------------------------------------------------------------------------------------
    init(_ firebaseAuth: FirebaseAuthProtocol = FirebaseAuth()){
        self.firebaseAuth = firebaseAuth
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func checkEmailValidPublisher()-> AnyPublisher<Bool, Never> {
        return textEmailSubject.map { value in
            return value != "" && value.count >= 5
        }.eraseToAnyPublisher()
    }
    
    
    
    func checkPasswordValidPublisher()-> AnyPublisher<Bool,Never> {
        return textPasswordSubject
            .map{value in
                return value.count >= 8
            }.eraseToAnyPublisher()
    }
    
    
    
    func combineTwoValidPublisher()-> AnyPublisher<Bool, Never>{
        return Publishers.CombineLatest(checkEmailValidPublisher(), checkPasswordValidPublisher()).map{ (emailValid , passwordValid) in
            return emailValid && passwordValid
        }.eraseToAnyPublisher()
    }
    
    
    func signInFirebase(){
        isLoading = true
        firebaseAuth?.signin(email: textEmailSubject.value, password: textPasswordSubject.value, completion: { [weak self] (_, error) in
            
            guard let self = self else{ return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {self.isLoading = false}
            if let error = error {print(error.localizedDescription)
                return
            }else {
                //Note: Going To Home
                print("Go to home")
            }
        })
    }
    
}
