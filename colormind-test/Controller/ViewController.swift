//
//  ViewController.swift
//  colormind-test
//
//  Created by Rudolf Paduraru on 02/08/2020.
//  Copyright © 2020 Rudolf Paduraru. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var change: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadItems()
    }
    
    @IBAction func changeValue(){
        activityIndicator.startAnimating()
        
        let red = Rgb.rgb.red
        let green = Rgb.rgb.green
        let blue = Rgb.rgb.blue
        
        ColormindAPI.requestColor()
        
        
        
        if Rgb.status {
            
            view.backgroundColor = UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: 0.5)
            
            Rgb.status = false
            
            activityIndicator.stopAnimating()
        }else{
            alertMessage(title:"Network Error", message: "Try again!")
            activityIndicator.stopAnimating()
        }
    }
    
    func alertMessage(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    
    @IBAction func saveColor(){
        let colorToSave = SavedColor(context: context)
        colorToSave.red = Rgb.rgb.red
        colorToSave.green = Rgb.rgb.green
        colorToSave.blue = Rgb.rgb.blue
        DataController.colorArray.append(colorToSave)
        
        try? self.context.save()
        
        alertMessage(title: "Saved", message: "Your color has been saved")
        
    }
    
    func saveItems() {
           do {
             try context.save()
           } catch {
              print("Error saving context \(error)")
           }
           
       }


    func loadItems(with request: NSFetchRequest<SavedColor> = SavedColor.fetchRequest(), predicate: NSPredicate? = nil) {
           
           
          do {
            DataController.colorArray = try context.fetch(request)
          } catch {
              print("Error fetching data from context \(error)")
          }
                       
      }
}

