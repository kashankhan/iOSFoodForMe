//
//  UIImageViewAsyncImageExtension.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import Foundation

extension UIImageView {
    func loadImage(uri: String, autoCache: Bool) {
        
        if let url: NSURL = NSURL(string: uri) {
            let urlId = url.hash
            var fileHandler = FileController()
            var cacheDir = "Documents/cache/images/\(urlId)"
            var existFileData = fileHandler.readFile(cacheDir)
            
            if existFileData == nil {
                NSURLSession.sharedSession().dataTaskWithURL(url) {
                    (data: NSData!, response: NSURLResponse!, error: NSError!) in
                    if error == nil {
                        dispatch_async(dispatch_get_main_queue()) { self.image = UIImage(data: data) }
                    }
                    }.resume()
            } else {
                image = UIImage(data: existFileData!)
            }
        }
        

    }
    
    private class FileController {
        func writeFile(fileDir: String, fileContent: NSData) -> Bool {
            var filePath = NSHomeDirectory().stringByAppendingPathComponent(fileDir)
            
            return fileContent.writeToFile(filePath, atomically: true)
        }
        
        func readFile(fileDir: String) -> NSData? {
            var filePath = NSHomeDirectory().stringByAppendingPathComponent(fileDir)
            if let fileHandler = NSFileHandle(forReadingAtPath: filePath) {
                var fileData = fileHandler.readDataToEndOfFile()
                fileHandler.closeFile()
                return fileData
            } else {
                return nil
            }
        }
        
        func mkdir(fileDir: String) -> Bool {
            var filePath = NSHomeDirectory().stringByAppendingPathComponent(fileDir)
            return NSFileManager.defaultManager().createDirectoryAtPath(filePath, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
    }
}


