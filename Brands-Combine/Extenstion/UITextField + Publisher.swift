//
//  UITextField + Publisher.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 12/12/2021.
//

import UIKit
import Combine

extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
    
    
    func creatTextFieldBinding(with subject: CurrentValueSubject<String, Never> , storeIn subscripations: inout Set<AnyCancellable>){
        
        subject.sink { [weak self] value in
            if value != self?.text {
                self?.text = value
            }
        }.store(in: &subscripations)
        
        
        self.textPublisher().sink { value in
            if value != subject.value {
                subject.send(value)
            }
        }.store(in: &subscripations)
        
        
    }
    
}

