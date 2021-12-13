//
//  FirebaseAuthUser.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 13/12/2021.
//

import Foundation
import Firebase

protocol FirebaseAuthProtocol: AnyObject {
    func signin(email: String , password: String, completion: @escaping(AuthDataResult? , Error?)-> Void)
    func signup(email: String , password: String, completion: @escaping(AuthDataResult? , Error?)-> Void)
}


class FirebaseAuth: FirebaseAuthProtocol {
    
    private let auth = Auth.auth()
    
    func signin(email: String , password: String, completion: @escaping(AuthDataResult? , Error?)-> Void) {
        auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signup(email: String , password: String, completion: @escaping(AuthDataResult? , Error?)-> Void){
        auth.createUser(withEmail: email, password: password, completion: completion)
    }
    
}
