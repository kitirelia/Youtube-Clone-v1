//
//  ApiService.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 22/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    let baseUrl:String = "https://aure.cc/youtube-clone/static"
    
    func fetchVideos(completion:@escaping([Video])->()){
        print("\(baseUrl)/home.json")
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json",completion: completion)
    }
    
    func fetchTrendingFeed(completion:@escaping([Video])->()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion:@escaping([Video])->()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json",completion: completion)
    }
    
    
    func fetchFeedForUrlString(urlString:String,completion:@escaping([Video])->()){
        let url = URL(string: urlString)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60.0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            if error != nil{
                print("Request json Error \(String(describing: error?.localizedDescription))")
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var videos = [Video]()
                
                for dictionary in json as! [[String:AnyObject]]{
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.video_url = dictionary["video_url"] as? String
                    video.numberOfViews = dictionary["number_of_views"]  as? NSNumber
                    let channelDictionanry = dictionary["channel"] as! [String:AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionanry["name"] as? String
                    channel.profileImageName = channelDictionanry["profile_image_name"] as? String
                    channel.subscribers = channelDictionanry["subscribers"] as? NSNumber
                    video.channel = channel
                    
                    
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    completion(videos)
                }
            }catch let jsonError{
                print(jsonError)
            }
            }.resume()
    }
    
    
}
