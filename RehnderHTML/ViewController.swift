//
//  ViewController.swift
//  RehnderHTML
//
//  Created by Mohamed El-Alfy on 7/18/15.
//  Copyright (c) 2015 Mohamed El-Alfy. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var baseURL = "http://www.assmt.com/json_1.1/get.aspx"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, baseURL , parameters: ["type": "01"])
            .responseString { request , _, string , _ in
                
                    var bodyContent:String {
                        var fristContent = string!.substringFromIndex(advance(string!.startIndex,41))
                        var lastContent = fristContent.substringToIndex(advance(fristContent.startIndex,51739))
                        return lastContent
                    }
                
                dispatch_async(dispatch_get_main_queue()){
                    var content = String(htmlEncodedString: bodyContent)
                    var html = NSMutableString(string: "<!DOCTYPE html><html><head><title></title></head><body style=\"background:transparent;\">")
                    html.appendString(content)
                    html.appendString("</body></html>")
                    self.webView.loadHTMLString(html.description, baseURL: nil)
                }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension String {
    init(htmlEncodedString: String) {
        let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        let attributedString = NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil, error: nil)!
        self.init(attributedString.string)
    }
}


