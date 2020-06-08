//
//  HomeTableHeaderView.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UIView {
    
    let labelHeader:UILabel = {
        let label = UILabel()
        label.font = .boldAppTitle
        label.text = ConstantString.shared.ConstantAppTitle
        label.backgroundColor = .white
        label.textColor = .lightGreyText
        return label
    }()
    
    let labelSubHeader1:UILabel = {
        let label = UILabel()
        label.font = .boldAppSubTitle
        label.text = ConstantString.shared.ConstantMyName
        label.backgroundColor = .white
        label.textColor = .lightGreyText
        return label
    }()
    
    let labelSubHeader2:UILabel = {
        let label = UILabel()
        label.font = .boldAppSubTitle
        label.text = ConstantString.shared.ConstantTodayDate
        label.backgroundColor = .white
        label.textColor = .lightGreyText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        let stack = UIStackView(arrangedSubviews: [labelHeader, labelSubHeader1, labelSubHeader2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 2
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fillEqually
            
        self.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
