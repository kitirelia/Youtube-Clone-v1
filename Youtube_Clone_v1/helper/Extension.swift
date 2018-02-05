//
//  Extension.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 18/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit


extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
   
}

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{
    func addConstraintsWithFormat(format:String,views:UIView...){
        var viewsDictionary = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension String{
    func shortNumber() -> String{
        let length = self.count
        let digits = self
        switch length {
        case 4:// 5,400 -> 5.4k
            let index4 = digits.index(digits.startIndex, offsetBy: 2)
            var char = digits.prefix(upTo: index4)
            let afterCut = Int(char)
            guard let intVal = afterCut else {return "xxx"}
            
            if intVal % 10 != 0{
                char.insert(".", at: char.index(after: char.startIndex))
            }else{
                char = digits.prefix(upTo: digits.index(digits.startIndex, offsetBy: 1))
            }
            return "\(char)k"
        case 5://43,000 -> 43k
            let index4 = digits.index(digits.startIndex, offsetBy: 2)
            return "\(digits.prefix(upTo: index4))k"
        case 6: //100,000 -> 100k
            let index4 = digits.index(digits.startIndex, offsetBy: 3)
            return "\(digits.prefix(upTo: index4))k"
        case 7...9:
            let cutAt = length - 6
            let index4 = digits.index(digits.startIndex, offsetBy: cutAt)
            return "\(digits.prefix(upTo: index4))M"
            
        case let x where x > 9:
            let cutAt = length - 9
            let index4 = digits.index(digits.startIndex, offsetBy: cutAt)
            return "\(digits.prefix(upTo: index4))B"

        default:
            return self
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString:String?
    
    func loadImageUsingUrlString(urlString:String){
        
        imageUrlString = urlString
        
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print("Load image error")
                return
            }
            DispatchQueue.main.async { // Correct
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as  AnyObject)
            }
        }).resume()
    }
    
}
