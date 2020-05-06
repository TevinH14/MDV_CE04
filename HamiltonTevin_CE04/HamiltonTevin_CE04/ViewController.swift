//
//  ViewController.swift
//  HamiltonTevin_CE04
//
//  Created by Tevin Hamilton on 9/13/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
   //an array to hold objects
    var redditData = [Reddit]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // call the download and parse extentions 
        downloadAndParse()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the count of the array
        return redditData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //reuse an existing cell or create a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID_1", for: indexPath)
        
       // add data from object array
        cell.textLabel?.text = redditData[indexPath.row].title
        cell.detailTextLabel?.text = redditData[indexPath.row].author
        cell.imageView?.image = redditData[indexPath.row].thumbnail
        
        return cell
    }

}

