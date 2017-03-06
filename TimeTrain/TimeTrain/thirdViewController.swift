//
//  thirdViewController.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/2/23.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import CoreData

class thirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                print("theme: \(p.value(forKey: "theme")!) time: \(p.value(forKey: "time")!) timeInterval: \(p.value(forKey: "timeInterval")!) tetx: \(p.value(forKey: "text")!) isFinish:\(p.value(forKey: "isFinish")!)" )
            }
        } catch  {
            print(error)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInfo()
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
