//
//  HomeViewController.swift
//  iCook
//
//  Created by Udumala, Mary on 6/22/17.
//  Copyright © 2017 Udumala, Mary. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "iCOOK"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(TypeCell.self, forCellWithReuseIdentifier: "typeCell")
        
        setUpNavBarItem()
        
    }
    
    func setUpNavBarItem() {
        let menuItem = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        let menuBarItem = UIBarButtonItem(image: menuItem, style: .plain, target: self, action: #selector(slideMenu))
        navigationItem.leftBarButtonItem = menuBarItem
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        YoutubeClient.sharedInstance().getVideos(query: "Kids Meal Recipies") { (results, error) in
            if error != nil {
                print("found an error")
            } else {
                print("***************************************************")
                print(results!)
            }
        }
    }
    
   
    func slideMenu() {
        print("123")
    }



}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

