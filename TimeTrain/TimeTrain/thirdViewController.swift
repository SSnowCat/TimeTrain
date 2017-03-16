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
    @IBAction func editTable(_ sender: UIButton) {
        sender.setTitle(infoTable.isEditing ? "Edit" : "Done", for: .normal)
        infoTable.setEditing(!infoTable.isEditing, animated: true)
            

    }
    
    @IBAction func cancelToHistory(segue: UIStoryboardSegue)
    {
        
    }
    override func viewDidLoad() {
        
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            infoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let name = infoList.remove(at: sourceIndexPath.row)
        infoList.insert(name, at: destinationIndexPath.row)
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
            cell.isFinishImg.image = #imageLiteral(resourceName: "完成部分的")
        }else{
            cell.isFinishImg.image = #imageLiteral(resourceName: "完成的")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let pillmodel = pillModel()
        if let svc = segue.destination as? DetailHistoryViewController {
            //which row?
            if let indexPath = infoTable.indexPath(for: sender as! UITableViewCell) {
                pillmodel.title = infoList[indexPath.row]["theme"]
                pillmodel.time = infoList[indexPath.row]["time"]
                pillmodel.detail = infoList[indexPath.row]["text"]
                pillmodel.isfinish = infoList[indexPath.row]["isFinish"]
                svc.pillmodel = pillmodel
                
                
            }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
