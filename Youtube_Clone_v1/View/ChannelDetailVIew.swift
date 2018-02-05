//
//  ChannelDetailVIew.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 2/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ChannelDetailView:UIView {
    
    let profileImageView:CustomImageView = {
        let image = UIImage(named:"jyp")
        let imageView = CustomImageView(image: image)
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
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let memberSubscribeLabel:UILabel =  {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "6M"
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    var labelView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
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
    
    var isSubscribe = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
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
        
        
        subscribeButton.addTarget(self, action: #selector(subscriptBtnTap), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let topBorder = CALayer()
        
        topBorder.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 1)
        
        topBorder.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.layer.addSublayer(topBorder)
        
        let bottomBorder = CALayer()
        
        bottomBorder.frame = CGRect(x: 0, y: bounds.size.height, width: bounds.size.width, height: 1)
        bottomBorder.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) 
        self.layer.addSublayer(bottomBorder)
    }
    
    @objc func subscriptBtnTap(){
        
        
        if isSubscribe{
//            subscribeButton.titleLabel?.textColor = UIColor.cyan
            subscribeButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            subscribeButton.setTitle("SUBSCRIBED", for: .normal)
        }else{
//            subscribeButton.titleLabel?.textColor = UIColor.blue
            subscribeButton.setTitle("SUBSCRIBE", for: .normal)
            subscribeButton.backgroundColor = UIColor.rgb(red: 235, green: 51, blue: 36)
        }
        isSubscribe = !isSubscribe
    }
    
    
    func setupUI(video:Video){
        if let channelName = video.channel?.name,let subscribers = video.channel?.subscribers,let profile_url =  video.channel?.profileImageName{
            channelNameLabel.text = channelName
            let shortString = "\(subscribers)"
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
//            let num_of_subscriber = numberFormatter.string(from: subscribers)
//            memberSubscribeLabel.text = "\(num_of_subscriber!) subscribers"
             memberSubscribeLabel.text = "\(shortString.shortNumber()) subscribers"
            profileImageView.loadImageUsingUrlString(urlString: profile_url)
            isSubscribe = false
        }
        
    }
    
    
}
