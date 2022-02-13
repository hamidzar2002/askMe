//
//  MainViewController.swift
//  Askme
//
//  Created by Hamid Zarrazvand on 8/12/17.
//  Copyright © 2017 com.zarrazvand.Askme. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField:UITextField?
    @IBOutlet weak var webView:UIWebView?
    @IBOutlet weak var textView:UITextView?
 var extract:String? = "Could not find any answer :("
    
    var data:NSMutableData = NSMutableData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func AskMe(_ sender: Any) {
    // https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrsearch=meaning&prop=info
    /*    var urlString:String? = ""
        urlString = "http://www.google.com/search?q=\(String(describing: textField!.text!))"
        urlString = urlString?.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "", with: "")
        let url:URL? = URL(string: urlString!)
        let request = NSURLRequest(url: url! as URL)
        self.webView!.loadRequest(request as URLRequest)
 */
        
        search(criteria: String(describing: textField!.text!))
     /*
        var urlString:String? = ""
        urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=\(String(describing: textField!.text!))"
        urlString = urlString?.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "", with:"")
        let url:URL? = URL(string: urlString!)
   
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let root = parsedData["query"] as! [String:Any]
                    
                   // print(root)
                    
                      let pages = root["pages"]  as! [String:Any]
                    
                    for (key) in pages {
                     //   let article = pages["\(key)"]  as! [String:Any]
                        let tempKey = key.key
                        
                        let article = pages["\(tempKey)"]  as! [String:Any]
                        
                        for(key) in article{
                            if  key.key == "extract" {
                                
                                self.extract = article["extract"] as! String
                                if self.extract == "" {
                                self.extract = "Could not find any result :("
                                }
                            }
                            else {
                            self.extract = "Could not find any result :("
                            }
                        }
                        DispatchQueue.main.async {
                            self.textView!.text = self.extract
                        }
                        
                        
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        
      */
       
    
        
        
          }
    
    
    func search(criteria :String) -> Void
    {
        
        self.textView!.text! = ""
        var urlString:String? = ""
        urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrsearch=\(criteria)&prop=extracts&explaintext="
        //urlString = urlString?.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "", with:"")
        let url:URL? = URL(string: urlString!)
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let root = parsedData["query"] as! [String:Any]
                    var title:String? = ""
                    var extracts:String? = ""
                    var pageId:Double? = 0
                    // print(root)
                    
                    let pages = root["pages"]  as! [String:Any]
                    
                    for (key) in pages {
                        //   let article = pages["\(key)"]  as! [String:Any]
                        let tempKey = key.key
                        
                        let listofArticles = pages["\(tempKey)"]  as! [String:Any]
                        
                        for(key) in listofArticles{
                            if  key.key == "title" {
                                
                                title = listofArticles["title"] as! String
                            }
                            else if key.key == "pageid" {
                                pageId = listofArticles["pageid"] as! Double
                        
                            }
                            
                            else if key.key == "extract" {
                                extracts = listofArticles["extract"] as! String
                            }
                            
                        }
                        
                        
                        DispatchQueue.main.async {
                            self.textView!.text = "\(self.textView!.text!)  \(title!), \(pageId!) : \n \(extracts!) \n\n"
                            
                        }
                        
                        
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
//https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&prop=extracts&exintro=&explaintext=&pageids=???
    
    }
    
  
    

}
