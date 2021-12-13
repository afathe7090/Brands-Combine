//
//  RegisterViewModel.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 13/12/2021.
//

import Foundation
import Combine


protocol RegisterViewModelProtocol: AnyObject {
    
    var isLoading: Bool {get}
    var isLoadingPublisher: Published<Bool>.Publisher {get}
    
    var emailTextPublisher: CurrentValueSubject<String,Never> {get}
    var passwordTextPublisher: CurrentValueSubject<String,Never> {get}
    var re_PasswordTextPublisher: CurrentValueSubject<String,Never> {get}
    
    func isEmailValid()-> AnyPublisher<Bool,Never>
    func isPasswordIsValid()-> AnyPublisher<Bool, Never>
    func isRe_PasswordIsValid()-> AnyPublisher<Bool, Never>
    func isPasswordEqualRe_password()-> AnyPublisher<Bool, Never>
    func isAllReadyToSignUp()-> AnyPublisher<Bool,Never>
    func registerUser()
}



class RegisterViewModel: RegisterViewModelProtocol{
    
    @Published var isLoading: Bool = false
    var isLoadingPublisher: Published<Bool>.Publisher {$isLoading}
    
    var emailTextPublisher: CurrentValueSubject<String,Never> = CurrentValueSubject<String,Never>("")
    var passwordTextPublisher: CurrentValueSubject<String, Never> = CurrentValueSubject<String,Never>("")
    var re_PasswordTextPublisher: CurrentValueSubject<String, Never> = CurrentValueSubject<String,Never>("")
    
    var subscripation = Set<AnyCancellable>()
    var firebaseAuth: FirebaseAuthProtocol?
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(_ firebaseAuth: FirebaseAuthProtocol = FirebaseAuth()){
        self.firebaseAuth = firebaseAuth
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Funcions
    //----------------------------------------------------------------------------------------------------------------
    
    
    func isEmailValid()-> AnyPublisher<Bool,Never>{
        return emailTextPublisher.map { value in
            return value.count >= 5
        }.eraseToAnyPublisher()
    }
    
    
    func isPasswordIsValid()-> AnyPublisher<Bool, Never> {
        return passwordTextPublisher.map { value in
            return value.count >= 8
        }.eraseToAnyPublisher()
    }
    
    func isRe_PasswordIsValid()-> AnyPublisher<Bool, Never> {
        return re_PasswordTextPublisher.map { value in
            return value.count >= 8
        }.eraseToAnyPublisher()
    }
    
    
    func isPasswordEqualRe_password()-> AnyPublisher<Bool, Never>{
        return Publishers.CombineLatest(passwordTextPublisher, re_PasswordTextPublisher).map { (pass , Re_pass) in
            return pass == Re_pass
        }.eraseToAnyPublisher()
    }
    
    
    func isAllReadyToSignUp()-> AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest3(isPasswordIsValid(), isRe_PasswordIsValid(), isPasswordEqualRe_password()).map { (pass , repass , valid) in
            return pass && repass && valid
        }.eraseToAnyPublisher()
    }
    
    
    func registerUser(){
        isLoading = true
        firebaseAuth?.signup(email: emailTextPublisher.value, password: passwordTextPublisher.value, completion: { [weak self] _, error in

            guard let self = self else{ return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {self.isLoading = false}
            if error != nil {print(error!.localizedDescription) ; return}
        })
    }

    
    
}
