//
//  TrendingCell.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 22/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    
    override var videoUrl : String {
        get {
            return "https://aure.cc/youtube-clone/video/kold_my_year.mp4"
        }
        set {
            // nothing, because only red is allowed
        }
    }
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos:[Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
