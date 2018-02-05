//
//  ViewController.swift
//  Youtube_Clone_v1
//
//  Created by kitiwat chanluthin on 17/1/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout,FeedCellDelegate {
    
    let cellId = "cellId"
    let trendingCellId = "trendingId"
    let subscriptionCellId = "subscriptionId"
    let titles = ["Home","Trending","Subscription","Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
        
        
        //-----------  test
        let single = "4"
        let two_digit = "12"
        let hundred = "123"
        let thousand = "3000"
        let thousand2 = "5430"
        
        let ten_thounsand = "62703"
        let hundred_thounsand = "324588"
        let one_million = "5037400"
        let ten_million = "12345970"
        let hundred_million = "312345970"
        
        let single_billion = "3080253319"
        let hundred_billion = "34786046171"
        
        print("-------------")
        print("\(single) is \(single.shortNumber()) view")
        print("\(two_digit) is \(two_digit.shortNumber()) view")
        print("\(hundred) is \(hundred.shortNumber()) view")
        print("\(thousand) is \(thousand.shortNumber()) view")
        print("\(thousand2) is \(thousand2.shortNumber()) view")
        print("    ---   ")
        print("\(ten_thounsand) is \(ten_thounsand.shortNumber()) view")
        print("\(hundred_thounsand) is \(hundred_thounsand.shortNumber()) view")
        
        print(" ----  1M ---")
        print("\(one_million) is \(one_million.shortNumber()) view")
        print("\(ten_million) is \(ten_million.shortNumber()) view")
        print("\(hundred_million) is \(hundred_million.shortNumber()) view")
        print("----- Billion")
        print("\(single_billion) is \(single_billion.shortNumber()) view")
        print("\(hundred_billion) is \(hundred_billion.shortNumber()) view")
        
        print("---------\n")
        
        
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
    }

    lazy var menuBar:MenuBar = {
       let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupNavBarButtons(){
        let searchImage = UIImage(named:"search_icon_2")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named:"three_dots_small")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
    }
    
    @objc func handleSearch(){
        print("search")
        
    }
    
    func scrollToMenuIndex(menuIndex:Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    lazy var settingLauncher : SettingLauncher =  {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    lazy var videoLauncher:VideoLauncher = {
       let launcher = VideoLauncher()
        return launcher
    }()
    
    @objc func handleMore(){
        settingLauncher.showSettings()
    }
    
    func showControllerForSettings(setting:Setting){
//        let dummySettingViewController = UIViewController()
//        dummySettingViewController.view.backgroundColor = UIColor.white
//        dummySettingViewController.navigationItem.title = setting.name.rawValue
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }

    func setTitleForIndex(index:Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    private func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
     
        setTitleForIndex(index: Int(index))
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier:String!
        
        if indexPath.item == 1{
            identifier = trendingCellId
        }else if indexPath.item == 2{
            identifier = subscriptionCellId
        }else{
            identifier = cellId
        }
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FeedCell{
        cell.feedCellDelegate = self
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func feedCellTapped(video: Video) {
//        print("call from feed cell")
//        videoLauncher.showVideoPlayer(video: video)
        videoLauncher.playNewVideo(video: video)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
  

}



















