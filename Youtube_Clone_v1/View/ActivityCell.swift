//
//  ActivityCell.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 5/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ActivityCell: UICollectionViewCell {
    
    lazy var bellImageView:UIImageView = {
        let image = UIImage(named:"bell")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return imageView
    }()
    
    let titleLbl:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        label.text = "Your notifications live here."
        label.font = UIFont(name: label.font.fontName, size: 20)
        return label
    }()
    
    let subtitleLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "Don't miss the lastest video from your favourite channels."
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let turnOnNotiButton:UIButton = {
        let button = UIButton()
        button.setTitle("TURN ON NOTIFICATION", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font =  UIFont(name:"HelveticaNeue-Bold", size: 14)
        button.backgroundColor = UIColor.rgb(red: 80, green: 133, blue: 237)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        self.contentView.addSubview(bellImageView)
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(subtitleLbl)
        self.contentView.addSubview(turnOnNotiButton)
        self.contentView.addConstraintsWithFormat(format: "V:|-60-[v0(100)]", views: bellImageView)
        self.contentView.addConstraintsWithFormat(format: "V:[v0]-30-[v1]-30-[v2]-30-[v3(40)]", views: bellImageView,titleLbl,subtitleLbl,turnOnNotiButton)
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: bellImageView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: titleLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        self.contentView.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: subtitleLbl)
        
        self.contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: turnOnNotiButton)
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: subtitleLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: turnOnNotiButton, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
