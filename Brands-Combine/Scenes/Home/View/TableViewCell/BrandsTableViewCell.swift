//
//  BrandsTableViewCell.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import UIKit

class BrandsTableViewCell: UITableViewCell {

    static let cellID  = "BrandsTableViewCell"
    
    @IBOutlet weak var backView: UIView!{didSet{backView.set_Shadow_For_View(cornerRadius: 20, shadowColor: UIColor.gray.cgColor, shadowRadius: 5)}}
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandCounterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(data: BrandsData){
        self.brandCounterLabel.text = "\(data.device_count)"
        self.brandNameLabel.text = data.brand_name
    }
    
}

