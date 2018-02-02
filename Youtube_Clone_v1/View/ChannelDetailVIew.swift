//
//  ChannelDetailVIew.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 2/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ChannelDetailView:UIView {
    
    let profileImageView:UIImageView = {
        let image = UIImage(named:"jyp")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let channelNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "jypentertainment"
        label.font = UIFont(name: label.font.fontName, size: 10)
        return label
    }()
    
    let subscribeButton:UIButton = {
       let button = UIButton()
        button.setTitle("SUBSCRIBE", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.rgb(red: 235, green: 51, blue: 36)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(profileImageView)
        self.addSubview(channelNameLabel)
        self.addSubview(subscribeButton)
        
        let ratio = (200 / 6)
        
        self.addConstraintsWithFormat(format: "H:|-8-[v0(\(2 * ratio))]-0@750-[v1(\(2 * ratio))]-0@500-[v2(\(2 * ratio))]-8-|", views: profileImageView,channelNameLabel,subscribeButton)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-8-|", views: profileImageView)
        self.addConstraintsWithFormat(format: "V:|-8-[v0]", views: channelNameLabel)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: subscribeButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
