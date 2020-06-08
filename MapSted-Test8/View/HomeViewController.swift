//
//  HomeViewController.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-06.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    private var viewModel = HomeViewModel()
    let alertView = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        viewModel.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectionChange(_:)), name: .ItemSelection, object: nil)

        
        let tableHeaderView = HomeTableHeaderView()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: CGFloat.greatestFiniteMagnitude)
        self.tableView.tableHeaderView = tableHeaderView
        self.tableView.sizeHeaderToFit()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = ConstantString.shared.ConstantHomeTableViewHeight // UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorColor = .white
        //tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        //tableView.isScrollEnabled = false
        startloading()
    }
    
    private func registerTableView() {
           
        self.tableView.register(HomeSectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: ConstantString.shared.CellIDHomeSectionHeader)
        self.tableView.register(TotalTypeTableViewCell.self, forCellReuseIdentifier: ConstantString.shared.CellIDTotalTypeCell)
       }
       
   private func startloading() {
    // When scaling will be using a time seed to get the detla values from the api's so that the same data is not requested for multiple times
    // Using caching here as the data remains the same for the scope of the task
        if CoreDataHelper.shared.retriveBuildingData() == nil {
            self.showSpinner(onView: tableView)
            print("Making Web Request")
            viewModel.MakeWebRequest()
        }else{
            print("Loading From DB")
            viewModel.prepareTableViewRowModel()
            tableView.reloadData()
        }

    }
    
    @objc func handleSelectionChange(_ sender:Notification) {
        
        if let selectionData = sender.object as? (TableViewDataSource,IndexPath) {
            viewModel.setPurchaseDataFor(section: selectionData.1.section, index: selectionData.1.item, data: selectionData.0)
            tableView.reloadRows(at: [selectionData.1], with: .fade)
        }
    }
    
  
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfDataSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfRowsIn(section: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ConstantString.shared.CellIDHomeSectionHeader) as! HomeSectionHeaderCell
        headerCell.setHeaderValue(title: viewModel.getPurchaseDataTitleFor(section: section))
        return headerCell
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantString.shared.CellIDTotalTypeCell, for: indexPath) as! TotalTypeTableViewCell
        cell.setCellValue(object: viewModel.getPurchaseDataFor(section: indexPath.section, index: indexPath.item))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseData = viewModel.getPurchaseDataFor(section: indexPath.section, index: indexPath.item)
        guard purchaseData.pickerSource != nil else { return }
        let vc = SelectionTableViewController()
        vc.pickedIndex = indexPath
        vc.dataSource = purchaseData
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

 

}

// MARK: - View Model Delegate Method

extension HomeViewController : ModelDelegate {
    func completedGroupOperation(refparam: ApiMethod) {
        if refparam == .BuildingAnalyticsGroup {
            tableView.reloadData()
            self.removeSpinner()
        }
    }
    
    func recievedResponce(refparam: ApiMethod) {
        
    }
    
    func errorResponce(_ value: String, refparam: ApiMethod) {
        
    }
    
}


extension UIViewController{
    
    private struct Holder {
        static var vSpinner : UIView?
        static var isadded = false
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        if !Holder.isadded {
            Holder.isadded = true
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            Holder.vSpinner = spinnerView
        }
    }
    
    func removeSpinner() {
        if Holder.isadded {
            Holder.isadded = false
            DispatchQueue.main.async {
                Holder.vSpinner?.removeFromSuperview()
                Holder.vSpinner = nil
            }
        }
    }
}
