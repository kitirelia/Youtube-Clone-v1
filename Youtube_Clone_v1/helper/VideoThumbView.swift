//
//  VideoThumbView.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 31/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

protocol VideoThumbViewDelegate{
    func pauseButtonTapped()
    func closeButtonTapped()
}

class VideoThumbView:UIView {
    
    var videoThumbDelegate:VideoThumbViewDelegate?
    
    var videoImageView:UIImageView = {
       // let image = UIImage(named: "mv_bitmap")
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var pausePlayButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "pause_24")
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray

        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "cancel")
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.darkGray
//        button.isHidden = true
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }()
    
    lazy var titleView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let titleLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()
    
    let subtitleLbl:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: label.font.fontName, size: 10)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        
        let ratio = frame.width / 5
        
        titleLbl.text = "TWICE Like OOH-AHH(OOH-AHH하게) M/V"
        subtitleLbl.text = "jypentertainment"
        
        titleView.addSubview(titleLbl)
        titleLbl.addSubview(subtitleLbl)
        
        self.addSubview(videoImageView)
        self.addSubview(titleView)
        self.addSubview(pausePlayButton)
        self.addSubview(closeButton)
        
        self.addConstraintsWithFormat(format: "H:|-0-[v0(\(1.75 * ratio))]-0-[v1(\(1.25 * ratio))]-0-[v2(\(1 * ratio))]-0-[v3(\(1 * ratio))]-0-|", views: videoImageView,titleView,pausePlayButton,closeButton)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: videoImageView)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: titleView)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: pausePlayButton)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: closeButton)
        
        titleView.addConstraintsWithFormat(format: "H:|-5-[v0]-0-|", views: titleLbl)
        titleView.addConstraintsWithFormat(format: "H:|-5-[v0]-0-|", views: subtitleLbl)
        titleView.addConstraintsWithFormat(format: "V:|-5-[v0]-5-[v1]", views: titleLbl,subtitleLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePause(){
//        print("pause ")
        videoThumbDelegate?.pauseButtonTapped()
    }
    
    @objc func handleClose(){
//        print("close")
        videoThumbDelegate?.closeButtonTapped()
    }
    
    func setPlayPauseState(isPlaying:Bool){
        if isPlaying{
           
            pausePlayButton.setImage(UIImage(named:"play_24"), for: .normal)
        }else{
            
            pausePlayButton.setImage(UIImage(named:"pause_24"), for: .normal)
        }
        
        
    }
    
}
