//
//  UITableView+.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//


import UIKit

extension UITableView {
    
    func sizeHeaderToFit() {
        let headerView = self.tableHeaderView!
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        
        self.tableHeaderView = headerView
    }
}

