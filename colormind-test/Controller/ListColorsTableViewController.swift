//
//  ListColorsTableViewController.swift
//  colormind-test
//
//  Created by Rudolf Paduraru on 02/08/2020.
//  Copyright © 2020 Rudolf Paduraru. All rights reserved.
//

import UIKit
import CoreData

class ListColorsTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataController.colorArray.count
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = DataController.colorArray[indexPath.row]
        
        let red = item.red
        let green = item.green
        let blue = item.blue
        
        cell.backgroundColor = UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: 0.5)
        
            
        return cell
    }


}
