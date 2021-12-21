//
//  BrandsDetailsViewController.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 15/12/2021.
//

import UIKit
import Combine
import CombineCocoa

class BrandsDetailsViewController: UIViewController {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    var viewModel: BrandsDetailsViewModelProtocol!
    var subscripation = Set<AnyCancellable>()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    
    init(_ viewModel: BrandsDetailsViewModelProtocol = BrandsDetailsViewModel()){
        super.init(nibName: "BrandsDetailsViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe cycle
    //----------------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleView()
        setTableVIew()
        tableVIewDataSourcePublisher()
        isLoadingPublisher()
        didSelectRowAt()
    }
    
    func setTitleView(){
        title = viewModel.brand?.brand_name
    }
    
    func setTableVIew(){
        tableView.rowHeight = 80
        tableView.register(UINib(nibName: DetailsTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.cellID)
    }
    
    
    func tableVIewDataSourcePublisher(){
        viewModel.fetchBrandsDetailsData()
        viewModel.brandsDetailsPublished.sink(receiveValue: tableView.items({ tableView, indexPath, modal in
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.cellID, for: indexPath) as! DetailsTableViewCell
            cell.setDataCell(modal)
            return cell
            
        })).store(in: &subscripation)
    }
    
    func isLoadingPublisher(){
        viewModel.isLoadingPublisher.sink { state in
            state ? Hud.showHud(in: self.view):Hud.dismiss()
        }.store(in: &subscripation )
    }
    
    func didSelectRowAt(){
        tableView.didSelectRowPublisher.sink { indexPath in
            let phoneViewModel = PhoneDetailsViewModel(phoneData: self.viewModel.brandsDetails[indexPath.row])
            let phoneVC = PhoneDetailsViewController(with: phoneViewModel)            
            
            self.navigationController?.pushViewController(phoneVC, animated: true)
        }.store(in: &subscripation)
    }
    
}
