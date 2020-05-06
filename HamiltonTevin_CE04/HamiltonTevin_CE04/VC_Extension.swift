//
//  VC_Extension.swift
//

import Foundation
import UIKit

extension ViewController {
    
    //Helper method to download and parse json at a url(String)
    func downloadAndParse() {
        let config = URLSessionConfiguration.default
        
        //Create a session
        let session = URLSession(configuration: config)
        
        //Validate URL to ensure that it is not a broken link
        if let validURL = URL(string: "https://www.reddit.com/r/iphone/.json") {
            
            //Create a task that will download whatever is found at validURL as a Data object
            let task = session.dataTask(with: validURL) { (data, response, error) in
                
                //If there is an error the bail out of this entire method (return)
                if let error = error {
                    
                    print("Data task failed with error " + error.localizedDescription)
                }
                
                //If we get this then we have gotten the info at the URL as a Data Object and we can now use it
                print("Success")
                
                func CheckForHttpString(title:String, thumbnail:String, author:String)
                {
                    //check if thumbnail contains https
                    if thumbnail.contains("https")
                    {
                     //print and check what url is being passed threw
                        print(thumbnail)
                        
                        //add download data to array that addeds the reddit object
                        self.redditData.append(Reddit(title: title, author: author, thumbnailString: thumbnail))
                    }
                }
                //Check response status, validate the data
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let validData = data
                    else {print("JSON Object creation failed."); return}
                do {
                    
                    // take in thw whole url data
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableLeaves) as? [String: Any]
                    
                    guard let json = jsonObj
                        else{print("something went wrong");return}
                    //dig threw the first level of the json object
                    for firstLevel in json
                    {
                        //get the value of data object
                        guard let dataOne = firstLevel.value as? [String: Any]
                            else{continue}
                        //reach the Second level data to reach the thrid level objects
                        guard let children = dataOne ["children"] as? [[String: Any]]
                            else{continue}
                       
                        //loop through the children array to get the remaing data.
                        for object in children
                        {
                            guard let dataTwo = object ["data"] as? [String: Any]
                                else{continue}
                            guard let title = dataTwo ["title"] as? String,
                            let thumbnail = dataTwo ["thumbnail"] as? String,
                            let author = dataTwo ["author"] as? String
                                else{continue}
                           
                            //pass requird data into nested function for check.
                            CheckForHttpString(title: title, thumbnail: thumbnail, author: author)
                        }
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    //reload the the tableview with data.
                    self.tableView.reloadData()
                }
                
            }
            
           //start task 
            task.resume()
        }
        print("Test")
        
    }
}

