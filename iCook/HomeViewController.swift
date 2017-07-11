//
//  HomeViewController.swift
//  iCook
//
//  Created by Udumala, Mary on 6/22/17.
//  Copyright © 2017 Udumala, Mary. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    
    var categories: [Category] = {
        
        var kidsMeals = Category()
        kidsMeals.thumbnailImageName = "KidsRecipiesThumbnail"
        kidsMeals.title = "Kids Healthy Recipies"
        
        var ketoRecipies = Category()
        ketoRecipies.thumbnailImageName = "KetoRecipiesThumbnail"
        ketoRecipies.title = "Keto Recipies"
        
        var LunchBoxRecipies = Category()
        LunchBoxRecipies.thumbnailImageName = "LunchBoxRecipiesThumbnail"
        LunchBoxRecipies.title = "Lunch Box Recipies"
        
        return [kidsMeals, ketoRecipies, LunchBoxRecipies]        
    }()

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
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCell
        cell.category = categories[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.navigationItem.title = categories[indexPath.item].title
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
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

