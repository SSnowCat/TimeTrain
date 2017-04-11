//
//  timeLineViewController.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/4/11.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import CoreData

class timeLineViewController: UIViewController {
    
    var searchResults:[Any] = []
    var detailView:DetailPillViewView? = nil
    var dataSource = NSMutableArray()

    var tmview:timeLineView = timeLineView()
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        for i in 0..<dataSource.count{
            
            tmview.modelArray.append(dataSource.object(at: i) as! pillModel)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
     
        let scrollewView = UIScrollView(frame: CGRect(x: 0, y: -70, width: 380, height: 720))
        scrollewView.backgroundColor = UIColor.clear
        tmview.frame = CGRect(x: 0, y: 65, width: 367, height: 60*tmview.modelArray.count + 65)
        scrollewView.contentSize = CGSize(width: 367, height: (60*tmview.modelArray.count)+65)
        scrollewView.addSubview(tmview)
        self.view.addSubview(scrollewView)
    }

       func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func getInfo(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeTrainInfo")
        do {
            searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
            
            for p in (searchResults as! [NSManagedObject]){
                print("theme: \(p.value(forKey: "theme")!) time: \(p.value(forKey: "time")!) timeInterval: \(p.value(forKey: "timeInterval")!) tetx: \(p.value(forKey: "text")!) isFinish:\(p.value(forKey: "isFinish")!)" )
                
                
                //set value to model
                
                let model = pillModel()
                model.title = p.value(forKey: "theme") as! String?
                model.timeInterval = p.value(forKey: "timeInterval") as! String?
                let swStr = p.value(forKey: "time") as! NSString
                //let str1 = swStr.substring(with: NSMakeRange(9, 8))
                model.detail = p.value(forKey: "text") as! String?
                model.time = swStr as String
                self.dataSource.add(model)
                
            }
            
        } catch  {
            print(error)
        }
        
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
