//
//  ListViewController.swift
//  iCook
//
//  Created by Udumala, Mary on 7/10/17.
//  Copyright © 2017 Udumala, Mary. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UICollectionViewController {
    
    var videos: [Video]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Arial", size: 19.0)!, NSForegroundColorAttributeName : UIColor.white]
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
        
        
        YoutubeClient.sharedInstance().getVideos(query: navigationItem.title!) { (results, error) in
            if error != nil {
                print("found an error")
            } else {
                self.videos = [Video]()
                for dictionary in results! {
                    let video = Video()
                    
                    if let snippet = dictionary["snippet"] as? [String: AnyObject], let thumbnails = snippet["thumbnails"] as? [String: AnyObject], let defaultImage = thumbnails["default"] as? [String: AnyObject], let url = defaultImage["url"], let title = snippet["title"], let channelName = snippet["channelTitle"] {
                        video.thumbnailUrl = url as? String
                        video.title = title as? String
                        video.channelTitle = channelName as? String
                    }
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.sync {
                    self.collectionView?.reloadData()
                }
            }
        }
    
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }


    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 280) * 9 / 16
        return CGSize(width: view.frame.width, height: height)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}




