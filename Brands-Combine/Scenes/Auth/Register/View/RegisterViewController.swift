//
//  RegisterViewController.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 13/12/2021.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    var viewModel: RegisterViewModelProtocol!
    var subscripation = Set<AnyCancellable>()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var re_passwordTextField: UITextField!
    @IBOutlet weak var re_passwordValidLabel: UILabel!
    @IBOutlet weak var registerButtonPressed: UIButton!
    @IBOutlet weak var loginButtonPreseed: UIButton!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(_ viewModel: RegisterViewModelProtocol = RegisterViewModel()){
        super.init(nibName: "RegisterViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        creatBindingFromTextFieldsToViewModel()
        setLoadingViewBinding()
        setPasswordValidationEffectToView()
        setRe_PasswordValidationEffectToView()
        setRegisterButtonBinding()
        setRegisterState()
        setLoginButtonBinding()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------

    
    
    func creatBindingFromTextFieldsToViewModel(){
        emailTextField.creatTextFieldBinding(with: viewModel.emailTextPublisher, storeIn: &subscripation)
        passwordTextField.creatTextFieldBinding(with: viewModel.passwordTextPublisher, storeIn: &subscripation)
        re_passwordTextField.creatTextFieldBinding(with: viewModel.re_PasswordTextPublisher, storeIn: &subscripation)
    }
    
    
    
    func setLoadingViewBinding(){
        viewModel.isLoadingPublisher.sink { state in
            state ? Hud.showHud(in: self.view):Hud.dismiss()
        }.store(in: &subscripation)
    }
    
    
    
    func setPasswordValidationEffectToView(){
        viewModel.isPasswordIsValid().sink {[weak self] state in
            guard let self = self else { return }
            self.passwordValidLabel.textColor = state ? .green:.red
            self.passwordValidLabel.text = state ? "Password Is Valid 😀😀 " : "You must Enter min 8 char "
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.2) {
                    self.passwordValidLabel.alpha = state ? 0:1
                }
            }
        }.store(in: &subscripation)
    }
    
    
    
    func setRe_PasswordValidationEffectToView(){
        viewModel.isRe_PasswordIsValid().sink { [weak self] state in
            
            guard let self = self else { return }
            self.re_passwordValidLabel.textColor = state ? .green:.red
            self.re_passwordValidLabel.text = state ? "Password Is Valid 😀😀 " : "You must Enter min 8 char "
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.2) {
                    self.re_passwordValidLabel.alpha = state ? 0:1
                }
            }
        }.store(in: &subscripation)
    }
    
    func setRegisterState(){
        viewModel.isAllReadyToSignUp().sink { state in
            self.registerButtonPressed.alpha = state ? 1:0.7
            self.registerButtonPressed.isEnabled = state
        }.store(in: &subscripation)
    }

    func setRegisterButtonBinding(){
        registerButtonPressed.tabPublisher.sink { _ in
            self.viewModel.registerUser()
        }.store(in: &subscripation)
    }
    
    func setLoginButtonBinding(){
        loginButtonPreseed.tabPublisher.sink { _ in
            self.navigationController?.popViewController(animated: true)
        }.store(in: &subscripation)
    }
    
    
}
