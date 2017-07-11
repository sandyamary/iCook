//
//  VideoCell.swift
//  iCook
//
//  Created by Udumala, Mary on 7/11/17.
//  Copyright © 2017 Udumala, Mary. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var video: Video? {
        didSet {
            name.text = video?.title
            loadThumbnailImage()
            views.text = "891,897 "+"views"
            channel.text = video?.channelTitle
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyan
        return imageView
    }()
    
    let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        return separator
    }()
    
    let name: UITextField = {
        let nameText = UITextField()
        nameText.font = UIFont.systemFont(ofSize: 16)
        nameText.isUserInteractionEnabled = false
        return nameText
    }()
    
    let views: UITextField = {
        let viewsText = UITextField()
        viewsText.font = UIFont.systemFont(ofSize: 12)
        viewsText.textColor = UIColor.lightGray
        viewsText.isUserInteractionEnabled = false
        return viewsText
    }()
    
    let channel: UITextField = {
        let channelText = UITextField()
        channelText.font = UIFont.systemFont(ofSize: 12)
        channelText.textColor = UIColor.lightGray
        channelText.isUserInteractionEnabled = false
        return channelText
    }()
    
    func loadThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailUrl {            
            let url = URL(string: thumbnailImageUrl)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(error ?? "Error downloading thumbnail images")
                    return
                }
                DispatchQueue.main.sync {
                    self.thumbnailImageView.image = UIImage(data: data!)
                }
            }
            task.resume()
        }
    }
    
//    let options: UIButton = {
//        let optionsIcon = UIButton()
//        optionsIcon.imageView?.image = UIImage(named: "MoreButton")
//        return optionsIcon
//    }()
    
    
    func setUpViews() {
        addSubview(thumbnailImageView)
        addSubview(name)
        addSubview(views)
        addSubview(channel)
        //addSubview(options)
        addSubview(separatorView)
        
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1(1)]|", views: thumbnailImageView, separatorView)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1]-2-[v2]-8-|", views: name, views, channel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(280)]-16-|", views: thumbnailImageView, name)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(280)]-16-|", views: thumbnailImageView, views)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(280)]-16-|", views: thumbnailImageView, channel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
    }
}








