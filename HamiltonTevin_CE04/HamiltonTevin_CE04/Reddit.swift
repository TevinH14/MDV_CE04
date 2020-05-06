//
//  Reddit.swift
//  HamiltonTevin_CE04
//
//  Created by Tevin Hamilton on 9/14/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import Foundation
import UIKit

class Reddit
{
     //Stored Properties
    let title: String
    let author: String
    var thumbnail: UIImage?
    
    //init
    init(title: String, author: String, thumbnailString: String)
    {
        
        self.title = title
        self.author = author
        
        //convert string into url
        if let url = URL(string: thumbnailString)
        {
            do {
                //try to convert to data
                let data = try Data(contentsOf: url)
                self.thumbnail = UIImage(data: data)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
