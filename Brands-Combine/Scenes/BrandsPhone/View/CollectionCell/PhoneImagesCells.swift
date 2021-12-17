//
//  PhoneImagesCells.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//

import UIKit
import Kingfisher

class PhoneImagesCells: UICollectionViewCell {

    
    static let cellID = "PhoneImagesCells"
    
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setUpCell(_ model: String){
        self.phoneImage.setImage(model)
    }
    
}
