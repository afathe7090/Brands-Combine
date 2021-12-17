//
//  DetailsTableViewCell.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    static let cellID = "DetailsTableViewCell"
    
    @IBOutlet weak var backView: UIView!{didSet{backView.set_Shadow_For_View(cornerRadius: 15, shadowColor: UIColor.lightGray.cgColor, shadowRadius: 3)}}
    @IBOutlet weak var brandsName: UILabel!
    @IBOutlet weak var brandsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataCell(_ brands: Phone){
        self.brandsName.text = brands.phone_name
        self.brandsImage.setImage(brands.image)
    }
    
    
    
}
