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
    func maximizeButtonTapped()
}

class VideoThumbView:UIView {
    
    var videoThumbDelegate:VideoThumbViewDelegate?
    
    var videoImageView:UIImageView = {
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
    
    lazy var gradientView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let ratio = (frame.width / 5)
        
        titleView.addSubview(titleLbl)
        titleLbl.addSubview(subtitleLbl)
        
        self.addSubview(gradientView)
        self.addSubview(videoImageView)
        videoImageView.isUserInteractionEnabled = true
        videoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap)))

        self.addSubview(titleView)
        self.addSubview(pausePlayButton)
        self.addSubview(closeButton)

        self.addConstraintsWithFormat(format: "H:|-8-[v0(\(1.75 * ratio))]-0-[v1(\(1.45 * ratio))]-0-[v2(\(0.8 * ratio))]-0-[v3(\(0.75 * ratio))]-8-|", views: videoImageView,titleView,pausePlayButton,closeButton)
        self.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: videoImageView)
        self.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: titleView)
        self.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: pausePlayButton)
        self.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: closeButton)

        titleView.addConstraintsWithFormat(format: "H:|-5-[v0]-0-|", views: titleLbl)
        titleView.addConstraintsWithFormat(format: "H:|-5-[v0]-0-|", views: subtitleLbl)
        titleView.addConstraintsWithFormat(format: "V:|-5-[v0]-5-[v1]", views: titleLbl,subtitleLbl)

        self.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: gradientView)
        self.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: gradientView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePause(){
        videoThumbDelegate?.pauseButtonTapped()
    }
    
    @objc func handleImageViewTap(){
        videoThumbDelegate?.maximizeButtonTapped()
    }
    
    @objc func handleClose(){
        videoThumbDelegate?.closeButtonTapped()
    }
    
    func setPlayPauseState(isPlaying:Bool){
        if isPlaying{
            pausePlayButton.setImage(UIImage(named:"play_24"), for: .normal)
        }else{
            
            pausePlayButton.setImage(UIImage(named:"pause_24"), for: .normal)
        }
    }

    func setupUI(video:Video){
         if let title = video.title,let channelName = video.channel?.name{
            titleLbl.text = title
            subtitleLbl.text = channelName
        }
    }
    
    private func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.0,0.8]
        self.layer.addSublayer(gradientLayer)
    }
    
}
