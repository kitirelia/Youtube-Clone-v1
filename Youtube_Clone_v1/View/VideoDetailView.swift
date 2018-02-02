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
        label.text = "TWICE Like OOH-AHH (OOH-AHH하게) M/V"
        label.textColor = UIColor.darkGray
        label.numberOfLines = 2
        label.backgroundColor = UIColor.red
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()
    
    lazy var numberOfViewsLabel:UILabel = {
        let label = UILabel()
        label.text = "2M views"
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.addSubview(titleLabel)
        self.addSubview(numberOfViewsLabel)
        
        self.addConstraintsWithFormat(format: "V:|-8-[v0]-8@750-[v1]-8-|", views: titleLabel,numberOfViewsLabel)
        self.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: titleLabel)
        self.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: numberOfViewsLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
