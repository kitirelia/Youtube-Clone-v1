//
//  VideoPlayerView.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 1/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoPlayerViewDelegate{
    func minimizeButtonDidTapped()
    func renderingVideoToBitmap(bitmapData:UIImage)
    func playPauseToggle(isPlaying:Bool)
}

class VideoPlayerView: UIView {
    
    var videoDelegate:VideoPlayerViewDelegate?
    var playUrl:String?
    var quPlayer:AVQueuePlayer?
    var isPlaying = false
    var isShowingControlButton = false
    var playerLayer:AVPlayerLayer?
    
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
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
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
    
    
    let controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    @objc func handleControlContainerTap(){
        if isShowingControlButton{
            hiddenContronView()
        }else{
            showControlButton()
        }
    }
    
    @objc func handleSwipeDown(){
        videoDelegate?.minimizeButtonDidTapped()
    }
    
    func hiddenContronView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.pausePlayButton.alpha = 0
            self.minimizeButton.alpha = 0
            self.minimizeButton.alpha = 0
            self.settingsButton.alpha = 0
            self.shareButton.alpha = 0
            self.watchLaterButton.alpha = 0
            self.fullScrennButton.alpha = 0
            self.videoLenghtLabel.alpha = 0
            self.currentTimerLabel.alpha = 0
            self.videoSlider.setThumbImage(UIImage(), for: .normal)
        }) { (completed:Bool) in
            self.isShowingControlButton = false
        }
    }
    
    func showControlButton(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.pausePlayButton.alpha = 1
            self.minimizeButton.alpha = 1
            self.minimizeButton.alpha = 1
            self.settingsButton.alpha = 1
            self.shareButton.alpha = 1
            self.watchLaterButton.alpha = 1
            self.fullScrennButton.alpha = 1
            self.videoLenghtLabel.alpha = 1
            self.currentTimerLabel.alpha = 1
            self.videoSlider.setThumbImage(UIImage(named:"red_circle_"), for: .normal)
        }) { (completed:Bool) in
            self.isShowingControlButton = true
           
            //self.videoLauncherView.alpha = 1
        }
    }
    
    @objc func handlePause(){
        videoDelegate?.playPauseToggle(isPlaying: isPlaying)
        if isPlaying{
            quPlayer?.pause()
            pausePlayButton.setImage(UIImage(named:"play_24"), for: .normal)
        }else{
            quPlayer?.play()
            pausePlayButton.setImage(UIImage(named:"pause_24"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc func handleShare(){
        
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
        
        if let duration = quPlayer?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            quPlayer?.seek(to: seekTime, completionHandler: { (completeSeek) in
            })
        }
    }
    // MARK: - Init
    
    func setupVideoPlayer(video:Video){
        print("setup video")
        handlePause()
        
        
        DispatchQueue.main.async {
            self.playUrl = video.video_url
            self.playVideoWithUrl(videoUrl: self.playUrl!)
        }
        
    }

    func setupVideoPlayer(){
        quPlayer = AVQueuePlayer.init()
        playerLayer = AVPlayerLayer(player: quPlayer)
        self.layer.addSublayer(playerLayer!)
        self.layer.frame = self.frame
        let selector = #selector(playerItemDidReachEnd(notification:))
        let name = NSNotification.Name.AVPlayerItemDidPlayToEndTime
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
        quPlayer?.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
        
        quPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        let interval = CMTime(seconds: 1/3,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        quPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            self.currentTimerLabel.text = "\(minutesString):\(secondsString)"
            
            DispatchQueue.main.async {
                self.videoDelegate?.renderingVideoToBitmap(bitmapData: self.accurateScreenShot())
            }
            
            if let duration = self.quPlayer?.currentItem?.duration{
                let durationSection = CMTimeGetSeconds(duration)
                
                self.videoSlider.value = Float(seconds / durationSection)
            }
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleControlContainerTap)))
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDown.direction = .down
        self.addGestureRecognizer(swipeDown)
        
        setupVideoPlayer()
        
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
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        hiddenContronView()
        
        
    }
    
    func accurateScreenShot()-> UIImage {
        guard let items = quPlayer?.items() else {
            return UIImage()
        }
        let item = items.first
        guard let asset = item?.asset else {return  UIImage()}
        do{
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            imgGenerator.requestedTimeToleranceAfter = kCMTimeZero
            imgGenerator.requestedTimeToleranceBefore = kCMTimeZero
            
            let cgImage = try imgGenerator.copyCGImage(at: (item?.currentTime())!, actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)
            return resizeImage(image: uiImage, newWidth: 100)!
        }catch {
            return UIImage()
        }
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func playVideoWithUrl(videoUrl:String){
        hiddenContronView()
        if let url = URL(string: videoUrl){
            quPlayer?.pause()
            let asset = AVAsset(url: url)
            quPlayer?.removeAllItems()
            let playerItem = AVPlayerItem(asset: asset)
            quPlayer?.insert(playerItem, after: nil)
            quPlayer?.play()
            
            let seconds = CMTimeGetSeconds(asset.duration)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            videoLenghtLabel.text = "\(minutesString):\(secondsString)"
        }
    }
    
    @objc func playerItemDidReachEnd(notification: Notification)
    {
        print("\n\nVideo Finish ")
        let item = quPlayer?.currentItem!
        quPlayer?.remove(item!)
        item?.seek(to: kCMTimeZero, completionHandler: nil)
        quPlayer?.insert(item!, after: nil)
        handlePause()
        showControlButton()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicationView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            isPlaying = true
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
