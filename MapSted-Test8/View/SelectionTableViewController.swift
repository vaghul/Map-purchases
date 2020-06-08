//
//  SelectionTableViewController.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class SelectionTableViewController: UITableViewController {

    var dataSource:TableViewDataSource!
    var pickedIndex:IndexPath!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ConstantString.shared.CellIDUITableView)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.title = dataSource.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: ConstantString.shared.ConstantCancel, style: .plain, target: self, action: #selector(self.onClickCancel))

    }
    
    @objc func onClickCancel(){
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.pickerSource?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantString.shared.CellIDUITableView, for: indexPath)
        if let object = dataSource.pickerSource?[indexPath.item] {
            cell.textLabel?.text = "\(object)"
            if "\(object)" == "\(dataSource.selection)" {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = dataSource.pickerSource?[indexPath.item] {
            dataSource.selection = object
            dataSource.value = CoreDataHelper.shared.retriveAnalyticsPurchaseData(feildName: dataSource.queryKey ?? "", feildValue: object, isSum: dataSource.isCost)
            NotificationCenter.default.post(name: .ItemSelection, object: (dataSource,pickedIndex))
            self.dismiss(animated: true, completion: nil)
        }
    }
   
}
