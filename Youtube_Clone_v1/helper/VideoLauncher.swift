//
//  VideoLauncher.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 23/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit
import AVFoundation


protocol VideoPlayerViewDelegate{
    func minimizeButtonDidTapped()
}

class VideoPlayerView: UIView {
    
    var videoDelegate:VideoPlayerViewDelegate?
    
    let activityIndicationView:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "pause_24")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    let minimizeButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named:"minimize")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMinimize), for: .touchUpInside)
        button.tintColor = UIColor.white
        return button
    }()
    
    let settingsButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named:"three_dots")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        return button
    }()
    
    let shareButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named:"share_media")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        return button
    }()
    
    let watchLaterButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named:"watch_later")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        return button
    }()
    
    let fullScrennButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        let image = UIImage(named:"full_screen")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        return button
    }()
    
    var playerLayer:AVPlayerLayer?
    let controlsContainerView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    var player:AVPlayer?
    var isPlaying = false
    
    @objc func handlePause(){
        if isPlaying{
            player?.pause()
            pausePlayButton.setImage(UIImage(named:"play_24"), for: .normal)
        }else{
            player?.play()
            pausePlayButton.setImage(UIImage(named:"pause_24"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    @objc func handleMinimize(){
        videoDelegate?.minimizeButtonDidTapped()
    }
    
  
    
    let videoLenghtLabel:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = UIColor.white
        return label
    }()
    
    let currentTimerLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var videoSlider:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.rgb(red: 102, green: 102, blue: 102)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(UIImage(named:"red_circle_"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange(){
        
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completeSeek) in
                
            })
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicationView)
        activityIndicationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(minimizeButton)
        minimizeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        minimizeButton.topAnchor.constraint(equalTo: topAnchor, constant: 22).isActive = true
        controlsContainerView.addConstraintsWithFormat(format: "H:[v0(19)]", views: minimizeButton)
        controlsContainerView.addConstraintsWithFormat(format: "V:[v0(10)]", views: minimizeButton)
        
        controlsContainerView.addSubview(settingsButton)
        settingsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        settingsButton.topAnchor.constraint(equalTo: minimizeButton.topAnchor, constant: 0).isActive = true
        controlsContainerView.addConstraintsWithFormat(format: "H:[v0(6)]", views: settingsButton)
        controlsContainerView.addConstraintsWithFormat(format: "V:[v0(20)]", views: settingsButton)
        
        controlsContainerView.addSubview(shareButton)
        shareButton.rightAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: -30).isActive = true
        shareButton.topAnchor.constraint(equalTo: minimizeButton.topAnchor, constant: 0).isActive = true
        controlsContainerView.addConstraintsWithFormat(format: "H:[v0(25)]", views: shareButton)
        controlsContainerView.addConstraintsWithFormat(format: "V:[v0(20)]", views: shareButton)
        
        controlsContainerView.addSubview(watchLaterButton)
        watchLaterButton.rightAnchor.constraint(equalTo: shareButton.leftAnchor, constant: -30).isActive = true
        watchLaterButton.topAnchor.constraint(equalTo: minimizeButton.topAnchor, constant: 0).isActive = true
        controlsContainerView.addConstraintsWithFormat(format: "H:[v0(25)]", views: watchLaterButton)
        controlsContainerView.addConstraintsWithFormat(format: "V:[v0(20)]", views: watchLaterButton)
        
        controlsContainerView.addSubview(fullScrennButton)
        fullScrennButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        fullScrennButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        controlsContainerView.addConstraintsWithFormat(format: "H:[v0(15)]", views: fullScrennButton)
        controlsContainerView.addConstraintsWithFormat(format: "V:[v0(14)]", views: fullScrennButton)
    
        controlsContainerView.addSubview(videoLenghtLabel)
         videoLenghtLabel.rightAnchor.constraint(equalTo: fullScrennButton.leftAnchor,constant: -15).isActive = true
        videoLenghtLabel.centerYAnchor.constraint(equalTo: fullScrennButton.centerYAnchor).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        controlsContainerView.addSubview(currentTimerLabel)
        currentTimerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        currentTimerLabel.centerYAnchor.constraint(equalTo: fullScrennButton.centerYAnchor, constant: 0).isActive = true
        currentTimerLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        currentTimerLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        controlsContainerView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: videoSlider)

        addConstraint(NSLayoutConstraint(item: videoSlider, attribute: .centerY, relatedBy: .equal, toItem: controlsContainerView, attribute: .centerY, multiplier: 1, constant: (frame.height/2) ))
        
        backgroundColor = UIColor.black
    }
    
    private func setupPlayerView(){
        let urlString = "https://aure.cc/youtube-clone/video/my_year.mp4"
        if let url = URL(string: urlString){
            player = AVPlayer(url: url)
            
            playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer!)
            self.layer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds) / 60)
                self.currentTimerLabel.text = "\(minutesString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration{
                    let durationSection = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSection)
                }
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicationView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration{
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
               
                videoLenghtLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        playerLayer?.frame = self.bounds
    }
    
    
    
    
    private func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.2]
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class VideoLauncher:NSObject,VideoPlayerViewDelegate{
    func minimizeButtonDidTapped() {
        minimizeView()
    }
    
    
    let blackView = UIView()
    
    func minimizeView(){
        if let keyWindow = UIApplication.shared.keyWindow{
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let minFrameWidth = (keyWindow.frame.width * 9 / 16) * 0.2
                let minFrameHeight = (keyWindow.frame.height * 9 / 16) * 0.2
                let frameY = keyWindow.frame.height - (keyWindow.frame.width * 9 / 16)
                self.blackView.frame = CGRect(x: 0, y: frameY, width: minFrameWidth, height: minFrameHeight)
            }) { (completed:Bool) in
                
                self.blackView.alpha = 0.5
                
            }
        }
    }
    
    func showVideoPlayer(){
        
        print("show player 111")
        if let keyWindow = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor.white
            blackView.frame = CGRect(x: keyWindow.frame.width - 50, y: keyWindow.frame.height - 50, width: 50, height: 50)
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            blackView.addSubview(videoPlayerView)
            videoPlayerView.videoDelegate = self
            
            keyWindow.addSubview(blackView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
    
    override init() {
        super.init()
        print("init Video Launcher 000")
    }
}

//class VideoLauncher:NSObject,VideoPlayerViewDelegate{
//    func minimizeButtonDidTapped() {
//        minimizeView()
//    }
//
//
//    let blackView = UIView()
//
//    func minimizeView(){
//        if let keyWindow = UIApplication.shared.keyWindow{
//            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                let minFrameWidth = (keyWindow.frame.width * 9 / 16) * 0.2
//                let minFrameHeight = (keyWindow.frame.height * 9 / 16) * 0.2
//                let frameY = keyWindow.frame.height - (keyWindow.frame.width * 9 / 16)
//                self.blackView.frame = CGRect(x: 0, y: frameY, width: minFrameWidth, height: minFrameHeight)
//            }) { (completed:Bool) in
//
//                self.blackView.alpha = 0.5
//
//            }
//        }
//    }
//
//    func showVideoPlayer(){
//
//        if let keyWindow = UIApplication.shared.keyWindow{
//            blackView.backgroundColor = UIColor.white
//            blackView.frame = CGRect(x: keyWindow.frame.width - 50, y: keyWindow.frame.height - 50, width: 50, height: 50)
//            let height = keyWindow.frame.width * 9 / 16
//            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
//            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
//            blackView.addSubview(videoPlayerView)
//            videoPlayerView.videoDelegate = self
//
//            keyWindow.addSubview(blackView)
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.blackView.frame = keyWindow.frame
//            }, completion: { (completedAnimation) in
//                UIApplication.shared.isStatusBarHidden = true
//            })
//        }
//    }
//}

