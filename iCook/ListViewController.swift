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
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
        
        
        YoutubeClient.sharedInstance().getVideos(query: navigationItem.title!) { (results, error) in
            if error != nil {
                print("found an error")
            } else {
                self.videos = [Video]()
                for dictionary in results! {
                    let video = Video()
                    video.title = dictionary["etag"] as? String
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
                
                
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(videos?.count ?? 0)
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        cell.backgroundColor = UIColor.blue
        return cell
    }

    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}




