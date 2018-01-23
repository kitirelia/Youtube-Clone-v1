//
//  VideoLauncher.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 23/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
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
        }
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher:NSObject{
    
    func showVideoPlayer(){
        print("Show video player animation....")
        
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
    
}
