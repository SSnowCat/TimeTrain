//
//  thirdViewController.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/2/23.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import CoreData

class thirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var infoList = [[String:String]]()
    @IBOutlet weak var infoTable: UITableView!
    @IBOutlet weak var isFinishImg: UIImageView!

    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func getInfo(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeTrainInfo")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
            
            for p in (searchResults as! [NSManagedObject]){
                print("theme: \(p.value(forKey: "theme")!) time: \(p.value(forKey: "time")!) timeInterval: \(p.value(forKey: "timeInterval")!) text: \(p.value(forKey: "text")!) isFinish:\(p.value(forKey: "isFinish")!)" )
                let itemDic:NSDictionary = ["theme" : p.value(forKey: "theme")!,"time" : p.value(forKey: "time")!,"timeInterval" : p.value(forKey: "timeInterval")!,"text" : p.value(forKey: "text")!,"isFinish" : p.value(forKey: "isFinish")!]
                self.infoList.append(itemDic as! [String : String])
            }
        } catch  {
            print(error)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(infoList.count)
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InfoTableViewCell
        
        // Configure the cell...
        let theme = infoList[indexPath.row]["theme"]
        let time = infoList[indexPath.row]["time"]
        cell.themeLabel.text = theme!
        let isFinished = infoList[indexPath.row]["isFinish"]
        print(isFinished!)
        if isFinished == "0" {
            cell.isFinishImg.image = #imageLiteral(resourceName: "t1")
        }else{
            cell.isFinishImg.image = #imageLiteral(resourceName: "t2")
        }
       
        
        cell.timeLabel.text = time!
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        infoList = []
        DispatchQueue.global().async {
            
            // 主线程异步执行（主线程同步可能会死锁）
            DispatchQueue.main.async(execute: {
                self.getInfo()
                self.infoTable.delegate = self
                self.infoTable.dataSource = self
                self.infoTable.reloadData()
            })
        }

    }

}
