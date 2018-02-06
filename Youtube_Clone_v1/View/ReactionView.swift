//
//  ReactionView.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 6/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ReactionView: UIView {

    
    
    lazy var likeButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "like-icon")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(handleLikeDisLike), for: .touchUpInside)
//        button.backgroundColor = UIColor.brown
        return button
    }()
    
    lazy var disLikeButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "dis-like-icon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        
        button.imageView?.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(handleLikeDisLike), for: .touchUpInside)
//        button.backgroundColor = UIColor.cyan
        return button
    }()
    
    lazy var sharedButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "share-icon")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
//        button.backgroundColor = UIColor.green
        return button
    }()
    
    lazy var downloadButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "download-icon")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(handleDownload), for: .touchUpInside)
//        button.backgroundColor = UIColor.red
        return button
    }()
    
    lazy var addToButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "add-to-icon")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(handleAddTo), for: .touchUpInside)
//        button.backgroundColor = UIColor.rgb(red: 80, green: 133, blue: 237)
        return button
    }()
    
    let numOfLikeLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "1M"
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 11)
        return label
    }()
    
    let numOfDisLikeLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "2.3K"
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        return label
    }()
    
    let shareLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Share"
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        return label
    }()
    
    let downloadLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Download"
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        return label
    }()
    
    let addToLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Add To"
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.addSubview(likeButton)
        self.addSubview(disLikeButton)
        self.addSubview(sharedButton)
        self.addSubview(downloadButton)
        self.addSubview(addToButton)
        
        self.addSubview(numOfLikeLbl)
        self.addSubview(numOfDisLikeLbl)
        self.addSubview(shareLbl)
        self.addSubview(downloadLbl)
        self.addSubview(addToLbl)
        
    }
    
    override func draw(_ rect: CGRect) {
        let leading = 5
        let ratio = (Float(frame.width) - Float(leading * 6 ))  / 5
        let bottom_constant = 20
        
        self.addConstraintsWithFormat(format: "V:|-5-[v0]-\(bottom_constant)-|", views: likeButton)
        self.addConstraintsWithFormat(format: "V:[v0]-2-|", views: numOfLikeLbl)
        self.addConstraint(NSLayoutConstraint(item: likeButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: numOfLikeLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        
        
        self.addConstraintsWithFormat(format: "V:|-5-[v0]-\(bottom_constant)-|", views: disLikeButton)
        self.addConstraintsWithFormat(format: "V:[v0]-2-|", views: numOfDisLikeLbl)
        self.addConstraint(NSLayoutConstraint(item: disLikeButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: numOfDisLikeLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        
        self.addConstraintsWithFormat(format: "V:|-5-[v0]-\(bottom_constant)-|", views: sharedButton)
        self.addConstraintsWithFormat(format: "V:[v0]-2-|", views: shareLbl)
        self.addConstraint(NSLayoutConstraint(item: sharedButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: shareLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        self.addConstraintsWithFormat(format: "V:|-5-[v0]-\(bottom_constant)-|", views: downloadButton)
        self.addConstraintsWithFormat(format: "V:[v0]-2-|", views: downloadLbl)
        self.addConstraint(NSLayoutConstraint(item: downloadButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: downloadLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        
        self.addConstraintsWithFormat(format: "V:|-5-[v0]-\(bottom_constant)-|", views: addToButton)
        self.addConstraintsWithFormat(format: "V:[v0]-2-|", views: addToLbl)
        self.addConstraint(NSLayoutConstraint(item: addToButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: addToLbl, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        
        self.addConstraintsWithFormat(format: "H:|-\(leading)-[v0(\(ratio))]-\(leading)-[v1(\(ratio))]-\(leading)-[v2(\(ratio))]-\(leading)-[v3(\(ratio))]-0@250-[v4(\(ratio))]-\(leading)-|", views: likeButton,disLikeButton,sharedButton,downloadButton,addToButton)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLikeDisLike(){
        
    }
    
    @objc func handleShare(){
        
    }
    
    @objc func handleDownload(){
        
    }
    @objc func handleAddTo(){
        
    }
    
}
