//
//  TotalTypeTableViewCell.swift
//  MapSted-Test8
//
//  Created by Vaghula Krishnan on 2020-06-07.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class TotalTypeTableViewCell: UITableViewCell {
    
    let labelStackTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .mediumTitle
        label.backgroundColor = .lightGreyBG
        label.textColor = .darkGreyText
        return label
    }()
   
    lazy var customStackSelection:UITextField = {
        let button = UITextField()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.font = .mediumTitle
        button.backgroundColor = .darkGreyBG
        button.textColor = .darkGreyText
        button.textAlignment = .left
        button.isUserInteractionEnabled = false
        button.leftView = StaticHelper.getEmptypadding()
        button.leftViewMode = .always
        button.rightViewMode = .always
        button.rightView = StaticHelper.getPaddingView()
        button.makeRoundBorder(radius:5)
        
        //button.setImage(image, for: .normal)
        return button
    }()
    
    let labelStackCost:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .mediumTitle
        label.backgroundColor = .lightGreyBG
        label.textColor = .darkGreyText
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = .lightGreyBG
        customStackSelection.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .horizontal)
        
        let stack = UIStackView(arrangedSubviews: [labelStackTitle, customStackSelection, labelStackCost])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 2
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        contentView.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        labelStackTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelStackTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        labelStackTitle.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        customStackSelection.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customStackSelection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        customStackSelection.widthAnchor.constraint(equalToConstant: 175).isActive = true
        
        labelStackCost.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelStackCost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellValue(object:TableViewDataSource) {
        labelStackTitle.text = object.title
        if let cost = object.value {
            customStackSelection.text = "\(object.selection)"
            customStackSelection.isHidden = false
            if object.isCost {
                labelStackCost.text = formatter.string(from: Double(cost)! as NSNumber)
            }else{
                labelStackCost.text = cost
            }
        }else{
            customStackSelection.isHidden = true
            labelStackCost.text = "\(object.selection)"
        }
      

    }
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
}

extension UIView {
    func makeRoundBorder(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
