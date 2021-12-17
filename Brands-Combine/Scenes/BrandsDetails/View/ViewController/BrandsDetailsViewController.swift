//
//  BrandsDetailsViewController.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 15/12/2021.
//

import UIKit

class BrandsDetailsViewController: UIViewController {

    
    var viewModel: BrandsDetailsViewModelProtocol!
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: BrandsDetailsViewModelProtocol = BrandsDetailsViewModel()){
        super.init(nibName: "BrandsDetailsViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe cycle
    //----------------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchBrandsDetailsData()
    }



}
