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
    func loadImage(url: String, autoCache: Bool) {
        var urlId = NSString(string: url).md5
        
        var fileHandler : NSFileController = NSFileController()
        var cacheDir : String = "Documents/cache/images/\(urlId)"
        var existFileData : NSData? = fileHandler.readFile(cacheDir)
        
        if (existFileData != nil) {
            var imageUrl = NSURL(string: url)
            var request = NSURLRequest(URL: imageUrl!)
            var requestQueue : NSOperationQueue = NSOperationQueue()
            println("uncache")
            NSURLConnection.sendAsynchronousRequest(request, queue: requestQueue, completionHandler:
                {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
                    if error != nil {
                        println("error")
                    }
                    else {
                        println(fileHandler.writeFile(cacheDir, fileContent: responseData))
                        self.image = UIImage(data: responseData)
                    }
            })
        }
        else {
            println("cache")
            self.image = UIImage(data: existFileData!)
        }
    }
}

class NSFileController : NSObject {
    var fileManager : NSFileManager = NSFileManager.defaultManager()
    func writeFile(fileDir: String, fileContent: NSData) -> Bool {
        var filePath : String = NSHomeDirectory().stringByAppendingPathComponent(fileDir)
        
        var writePointer : Bool = fileContent.writeToFile(filePath, atomically: true)
        return writePointer
    }
    
    func readFile(fileDir: String) -> NSData? {
        var filePath : String = NSHomeDirectory().stringByAppendingPathComponent(fileDir)
        var fileHandler : NSFileHandle = NSFileHandle(forReadingAtPath: filePath)!
        var fileData : NSData? = fileHandler.readDataToEndOfFile()
        fileHandler.closeFile()
        return fileData
    }
    
    func mkdir(fileDir: String) -> Bool {
        var filePath : String = NSHomeDirectory().stringByAppendingPathComponent(fileDir)
        var createHandler : Bool = fileManager.createDirectoryAtPath(filePath, withIntermediateDirectories: true, attributes: nil, error: nil)
        return createHandler
    }
}
