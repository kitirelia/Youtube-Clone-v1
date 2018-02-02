//
//  VideoLauncher.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 23/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLauncher:NSObject,VideoPlayerViewDelegate,VideoThumbViewDelegate{
    
    let videoLauncherView:UIView = UIView()
    var videoThumb:VideoThumbView!
    var videoPlayerView:VideoPlayerView!
    var whiteViewBG:UIView = UIView()
    
    override init(){
        super.init()
       if let keyWindow = UIApplication.shared.keyWindow{
 
            videoLauncherView.backgroundColor = UIColor.clear
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
        
            whiteViewBG.backgroundColor = UIColor.white
            videoLauncherView.addSubview(whiteViewBG)
        
            videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height))
            videoPlayerView.videoDelegate = self
            videoPlayerView.frame = videoPlayerFrame
            videoPlayerView.backgroundColor = UIColor.black
        
            videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
            videoLauncherView.addSubview(videoPlayerView)
        
            videoThumb = VideoThumbView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: 100))
            videoThumb.translatesAutoresizingMaskIntoConstraints = false
            videoThumb.videoThumbDelegate = self
        
            videoLauncherView.addSubview(videoThumb)
        
            videoLauncherView.addConstraintsWithFormat(format: "V:|-70-[v0(\(height))]", views: videoPlayerView)
            videoLauncherView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: videoPlayerView)
        
            videoLauncherView.addConstraintsWithFormat(format: "V:[v0]-[v1]-0-|", views: videoThumb,whiteViewBG)
        
        
        
            videoLauncherView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: whiteViewBG)
        
            videoLauncherView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: videoThumb)

            videoLauncherView.addConstraintsWithFormat(format: "V:|-0-[v1]-0-[v0]", views: videoPlayerView,videoThumb)
        
            keyWindow.addSubview(videoLauncherView)
        }
    }
    
    @objc func blackViewTap(){
        minimizeView()
    }
    
    func renderingVideoToBitmap(bitmapData: UIImage) {
        videoThumb.videoImageView.image = bitmapData
    }
    func playPauseToggle(isPlaying: Bool) {
        videoThumb.setPlayPauseState(isPlaying: isPlaying)
    }
    
    func minimizeView(){
        if let keyWindow = UIApplication.shared.keyWindow{
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                 let frameY = (keyWindow.frame.height - 10 - 10 - 50 )  // 10 from constraint 50 from thumb height
                self.videoLauncherView.frame = CGRect(x: 0, y: frameY, width: keyWindow.frame.width, height: keyWindow.frame.height)
            }) { (completed:Bool) in
                
            }
        }
    }
    
    func showVideoPlayer(withUrl url:String){
        if let keyWindow = UIApplication.shared.keyWindow{
            videoPlayerView.playUrl = url
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.videoLauncherView.frame = CGRect(x: 0, y: 0 - 10 - 10 - 50, width: keyWindow.frame.width, height: keyWindow.frame.height + 10 + 10 + 50)
            }, completion: { (completedAnimation) in
                self.videoPlayerView.playVideoWithUrl(videoUrl: url)
                UIApplication.shared.isStatusBarHidden = true
                self.videoPlayerView.layoutIfNeeded()
                
            })
        }
    }
    
    //------ delegate thumbvideo
    
    func maximizeButtonTapped() {
        if let keyWindow = UIApplication.shared.keyWindow{
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.videoLauncherView.frame = CGRect(x: 0, y: 0 - 10 - 10 - 50, width: keyWindow.frame.width, height: keyWindow.frame.height + 10 + 10 + 50)
            }, completion: { (completedAnimation) in
                
            })
        }
    }
    
    func minimizeButtonDidTapped() {
        minimizeView()
    }
    func thumbnailGenerated(thumbImage: UIImage?) {
        if let thumbImage = thumbImage{
            videoThumb.videoImageView.image = thumbImage
        }
    }
    func pauseButtonTapped() {
        print("pause")
        videoPlayerView.handlePause()
    }
    
    func closeButtonTapped() {
        print("cancel")
    }
    
    
}
