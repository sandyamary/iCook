//
//  YoutubeConvenience.swift
//  iCook
//
//  Created by Udumala, Mary on 6/30/17.
//  Copyright © 2017 Udumala, Mary. All rights reserved.
//

import Foundation

extension YoutubeClient {
    
    func getVideos(query: String, completionHandlerForVideos: @escaping (_ result: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
        let parameters = [String:String?]()
        let _ = self.taskForGETMethod(searchCategory: query, parameters: parameters) { (results, error) in
            
            if let error = error {
                completionHandlerForVideos(nil, error)
            } else {
                if let arrayOfVideoDictionaries = results?[Constants.YTResponseKeys.items] as? [[String: AnyObject]] {
                    completionHandlerForVideos(arrayOfVideoDictionaries, nil)
                }
                else {
                    completionHandlerForVideos(nil, NSError(domain: "getVideos parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getVideos"]))
                }
            }
        }
    }
}
