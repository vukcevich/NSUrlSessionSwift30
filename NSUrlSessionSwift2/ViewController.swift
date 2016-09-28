//
//  ViewController.swift
//  NSUrlSessionSwift2
//
//  Created by Marijan Vukcevich on 4/12/16.
//  Copyright © 2016 MagTek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url_to_request =  "http://www.kaleidosblog.com/tutorial/nsurlsession_tutorial.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        data_request()
        
        download_request()
        
        upload_request()
        
    }

    //NSURLSession: dataTaskWithUrl - dataTaskWithRequest example
    func data_request()
    {
        let url:NSURL = NSURL(string: url_to_request)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "data=Hello"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("data_request()- error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("dbg:data_request(): \(dataString)")
            
        }
        
        task.resume()
        
    }
    
    //NSURLSession: downloadTaskWithUrl - downloadTaskWithRequest example
    func download_request()
    {
        let url:NSURL = NSURL(string: url_to_request)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "data=Hello"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        
        let task = session.downloadTask(with: request as URLRequest) {
            (
            location, response, error) in
            
            guard let _:NSURL = location as NSURL?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let urlContents:NSString? = try! NSString(contentsOf: location!, encoding: String.Encoding.utf8.rawValue)
            
            guard let _ = urlContents else {
                print("download_request()-error")
                return
            }
            
            print("dbg:download_request(): \(urlContents)")
            
        }
        
        task.resume()
        
    }
    
    //NSURLSession: uploadTaskWithUrl - uploadTaskWithRequest example
    func upload_request()
    {
        let url:NSURL = NSURL(string: url_to_request)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let data = "data=Hi".data(using: String.Encoding.utf8)
        
        
        let task = session.uploadTask(with: request as URLRequest, from: data, completionHandler:
            {(data,response,error) in
                
                guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                    print("upload_request() - error")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("dbg:upload_request(): \(dataString)")
            }
        );
        
        task.resume()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

