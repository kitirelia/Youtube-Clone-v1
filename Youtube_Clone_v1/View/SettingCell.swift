//
//  SettingCell.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 19/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isSelected ? UIColor.white : UIColor.black
            iconImageView.tintColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting:Setting?{
        didSet{
            nameLabel.text = setting?.name.rawValue
            iconImageView.image = UIImage(named:(setting?.imageName)!)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor.darkGray
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named:"setting")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
       
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
