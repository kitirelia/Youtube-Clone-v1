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
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let channelNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "jypentertainment"
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return label
    }()
    
    let memberSubscribeLabel:UILabel =  {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "6M"
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return label
    }()
    
    var labelView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.brown
        return view
    }()
    
    let subscribeButton:UIButton = {
       let button = UIButton()
        button.setTitle("SUBSCRIBE", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font =  UIFont(name:"Helvetica", size: 12)
        button.backgroundColor = UIColor.rgb(red: 235, green: 51, blue: 36)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        self.addSubview(profileImageView)
        
        labelView.addSubview(channelNameLabel)
        labelView.addSubview(memberSubscribeLabel)
        labelView.addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: channelNameLabel)
        labelView.addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: memberSubscribeLabel)
        labelView.addConstraintsWithFormat(format: "V:|-2-[v0]-4@750-[v1]-2-|", views: channelNameLabel,memberSubscribeLabel)
        
        self.addSubview(labelView)
        self.addSubview(subscribeButton)
        
        self.addConstraintsWithFormat(format: "H:[v0(80)]-8-|", views: subscribeButton)
        self.addConstraintsWithFormat(format: "H:|-8-[v0(\(2 * 16))]-10@750-[v1]-8-[v2]", views: profileImageView,labelView,subscribeButton)
        
        self.addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: profileImageView)
        self.addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: labelView)
        self.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: subscribeButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
