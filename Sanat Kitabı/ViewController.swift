//
//  ViewController.swift
//  Sanat Kitabı
//
//  Created by Mert Ahmet Yiğit on 14.02.2018.
//  Copyright © 2018 Mert Yiğit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var yearArray = [Int]()
    var artistArray = [String]()
    var imageArray = [UIImage]()
    var secilenArt = ""
    
    
    
    
    
    func getInfo(){
        
        nameArray.removeAll(keepingCapacity: false)
        yearArray.removeAll(keepingCapacity: false)
        artistArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    if let year = result.value(forKey: "year") as? Int {
                        self.yearArray.append(year)
                    }
                    if let artist = result.value(forKey: "artist") as? String {
                        self.artistArray.append(artist)
                    }
                    if let imageData = result.value(forKey: "image") as? Data {
                        
                        let image = UIImage(data: imageData)
                            self.imageArray.append(image!)
                         }
                    
                    self.tableView.reloadData()
                    
                }
            }
            
            
            
        } catch {
            print("error")
        }
        
        
        
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getInfo()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        secilenArt = nameArray[indexPath.row]
         performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetayViewController
            destinationVC.choosingArt = secilenArt
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        
        secilenArt = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
        
    }
        
    }




    


