//
//  HomeViewController.swift
//  Brands-Combine
//
//  Created by Ahmed Fathy on 14/12/2021.
//

import UIKit
import Combine
import CombineCocoa

class HomeViewController: UIViewController {

    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    var subscripation = Set< AnyCancellable>()
    var viewModel: HomeViewModelProtocol!
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    
    init(_ viewModel: HomeViewModelProtocol = HomeViewModel()){
        super.init(nibName: "HomeViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        configureTableView()
        bindingLoadingToViewModel()
        tableViewDataSorceBinding()
        tableViewDidSelectRowAt()
    }

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    func configureTableView(){
        tableView.rowHeight = 70
        tableView.register(UINib(nibName: BrandsTableViewCell.cellID, bundle: nil),
                           forCellReuseIdentifier: BrandsTableViewCell.cellID)
    }
    
    func bindingLoadingToViewModel(){
        viewModel.isLoadingBublisher.sink { state in
            state ? Hud.showHud(in: self.view):Hud.dismiss()
        }.store(in: &subscripation)
    }
    
    
    func tableViewDataSorceBinding(){
        viewModel.fetchBrandsOfData()
        viewModel.brandsDataPublisher.sink(receiveValue: tableView.items{ (tableView, indexPath, model) in
            let cell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.cellID, for: indexPath) as! BrandsTableViewCell
            cell.setCell(data: model)
            return cell
        }).store(in: &subscripation)
        
        
    }
    
    func tableViewDidSelectRowAt(){
        tableView.didSelectRowPublisher.sink { indexPath in
            let brandsViewModel = BrandsDetailsViewModel(brand: self.viewModel.brandsData[indexPath.row])
            let brandsDetailVC = BrandsDetailsViewController(brandsViewModel)
            self.navigationController?.pushViewController(brandsDetailVC, animated: true)
        }.store(in: &subscripation)
    }
    
    
}
