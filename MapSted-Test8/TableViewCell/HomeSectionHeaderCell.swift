//
//  HomeSectionHeaderCell.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class HomeSectionHeaderCell: UITableViewHeaderFooterView {

    private let labelHeaderTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .semiboldTitle
        label.backgroundColor = .lightBlue
        label.textColor = .lightGreyText
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .lightBlue
        
        contentView.addSubview(labelHeaderTitle)
        
        labelHeaderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelHeaderTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelHeaderTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        labelHeaderTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderValue(title:String) {
        labelHeaderTitle.text = title
    }
    
}
