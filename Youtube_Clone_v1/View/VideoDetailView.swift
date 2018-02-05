//
//  VideoDetailView.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 2/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class VideoDetailView:UIView{
    
    
    lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        label.numberOfLines = 1
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: label.font.fontName, size: 15)
        return label
    }()
    
    lazy var numberOfViewsLabel:UILabel = {
        let label = UILabel()
//        label.text = "2M views"
        label.font = UIFont(name: label.font.fontName, size: 11)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(numberOfViewsLabel)
        
        self.addConstraintsWithFormat(format: "V:|-4-[v0]-4-[v1]-4-|", views: titleLabel,numberOfViewsLabel)
        self.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: titleLabel)
        self.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: numberOfViewsLabel)
        
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(video:Video){
        if let title = video.title,let numOfView = video.numberOfViews{
            
//            let numberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            let num_of_view = numberFormatter.string(from: numOfView)?.shortNumber()
//            print("num of view \(num_of_view)")
            let num_of_view = "\(numOfView)"
            numberOfViewsLabel.text = " \(num_of_view.shortNumber()) views"
            titleLabel.text = title
        }
    }
    
}
