//
//  LoginViewController.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 12/12/2021.
//

import UIKit
import CombineCocoa
import Combine

class LoginViewController: UIViewController {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    var viewModel: LoginViewModelProtocol!
    var subscripation = Set<AnyCancellable>()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var backView: UIView!{didSet{backView.layer.cornerRadius = 15}}
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButtonPressed: UIButton!{didSet{registerButtonPressed.layer.cornerRadius = 8}}
    @IBOutlet weak var loginButtonPressed: UIButton!{didSet{loginButtonPressed.layer.cornerRadius = 10}}
    @IBOutlet weak var passwordAlertLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Innit
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: LoginViewModelProtocol = LoginViewModel()){
        super.init(nibName: "LoginViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatTextFieldBinding()
        bindingToValidPassword()
        bindingToLoadingView()
        bindingToEnableOrDisableLoginButton()
        registerButtonActionsPublisher()
        loginButtonActionPublisher()
        StartBindingToGoHome()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    
    func creatTextFieldBinding(){
        emailTextField.creatTextFieldBinding(with: self.viewModel.textEmailSubject, storeIn: &subscripation)
        passwordTextField.creatTextFieldBinding(with: self.viewModel.textPasswordSubject, storeIn: &subscripation)
    }
    
    
    func bindingToLoadingView(){
        viewModel.isLoadingPublisher.sink {[weak self] state in
            
            guard let self = self else {return}
            state ? Hud.showHud(in: self.view):Hud.dismiss()
        }.store(in: &subscripation)
    }
    
    
    // we create Publisher To bind to the own TextField
    // and creat Combine all Publisher For check Valid
    func bindingToValidPassword(){
        viewModel.checkPasswordValidPublisher()
            .sink { [weak self] state in
                
                guard let self = self else{return}
                self.passwordAlertLabel.text = state ? "Password Is Valid 😀😀 " : "You must Enter min 8 char "
                self.passwordAlertLabel.textColor = state ? .green : .red
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    UIView.animate(withDuration: 0.2) {
                        self.passwordAlertLabel.alpha = state ? 0:1
                    }
                }
                
            }.store(in: &subscripation)
    }
    
    
    func bindingToEnableOrDisableLoginButton(){
        viewModel.combineTwoValidPublisher().sink { [weak self] state in
            guard let self = self else{return}
            self.loginButtonPressed.alpha = state ? 1:0.75
            self.loginButtonPressed.isEnabled = state
        }.store(in: &subscripation)
    }
    
    
    
    func loginButtonActionPublisher(){
        loginButtonPressed.tapPublisher.sink {[weak self] _ in
            guard let self = self else { return }
            self.viewModel.signInFirebase()
        }.store(in: &subscripation)
    }
    
    
    
    func registerButtonActionsPublisher(){
        registerButtonPressed.tapPublisher.sink { _ in
            let registeVC = RegisterViewController()
            self.navigationController?.pushViewController(registeVC, animated: true)
        }.store(in: &subscripation)
    }
    
    func StartBindingToGoHome(){
        viewModel.startGoToHomePagePublisher.sink { state in
            print(#function)
            
            switch state {
            case true :
                let homeVC = UINavigationController(rootViewController: HomeViewController())
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            case false :
                return 
            }
            
        }.store(in: &subscripation)
    }
    
}



