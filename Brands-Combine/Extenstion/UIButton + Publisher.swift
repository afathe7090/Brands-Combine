//
//  UIButton + Publisher.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 12/12/2021.
//

import UIKit
import Combine

extension UIButton {
    var tabPublisher: EventPublisher {
        publisher(for: .touchUpInside)
    }
}

