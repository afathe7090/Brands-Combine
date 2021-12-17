//
//  PhoneDetailsViewController.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//

import UIKit
import Combine
import CombineCocoa

class PhoneDetailsViewController: UIViewController {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Probeties
    //----------------------------------------------------------------------------------------------------------------
    
    var viewModel: PhoneDetailsViewModelProtocol!
    var subscripation = Set<AnyCancellable>()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  IbOutlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleBrandsLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var phoneNameLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(with viewModel: PhoneDetailsViewModelProtocol = PhoneDetailsViewModel()){
        super.init(nibName: "PhoneDetailsViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        startBindingToCollectionViewDataSorce()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper functions
    //----------------------------------------------------------------------------------------------------------------
    
    // collection View Adding Cell
    func setCollectionView(){
        collectionView.register(UINib(nibName: PhoneImagesCells.cellID, bundle: nil), forCellWithReuseIdentifier: PhoneImagesCells.cellID)
    }
    
    func startBindingToCollectionViewDataSorce(){
        
        viewModel.fetchPhoneData()
        
        viewModel.imagesPublisher
            .sink(receiveValue: collectionView.items({ (collectionView, indexPath, model) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneImagesCells.cellID, for: indexPath) as! PhoneImagesCells
            cell.setUpCell(model)
            return cell
        })).store(in: &subscripation)
    }
    
}
