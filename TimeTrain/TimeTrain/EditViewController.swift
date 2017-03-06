//
//  EditViewController.swift
//  TimeTrain
//
//  Created by Joe on 2017/3/2.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var themeText: UITextField!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var time: UIDatePicker!
    var timeIntervalString = ""
    var pickTimeString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
        if (themeText.text?.isEmpty)! {
            let alert = UIAlertController(title: "提示", message: "主题为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }else{
            if detailText.text.isEmpty {
                let alert = UIAlertController(title: "提示", message: "内容为空", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }else{
                if pickTimeString == "" {
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yy-MM-dd HH:mm:ss"
                    pickTimeString = formatter.string(from: date)
                    timeIntervalString = "现在"
                }
                let isfinish = "0"
                storeInfo(theme: themeText.text!, time: pickTimeString, timeInterval: timeIntervalString, text: detailText.text,isFinish:isfinish)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func changeValues(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        let dateString1 = formatter.string(from: date)
        let dateString2 = formatter.string(from: time.date)
        print("\(dateString1),\(dateString2)")
        pickTimeString = dateString2
        var diffComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: time.date)
        let year = diffComponents.year!
        let month = diffComponents.month!
        let day = diffComponents.day!
        let hour = diffComponents.hour!
        let minute = diffComponents.minute!
        let seconds = diffComponents.second!
        if year == 0 {
            if month == 0 {
                if day == 0 {
                    if hour == 0 {
                        if minute == 0 {
                            timeIntervalString = "现在"
                        }else{
                            timeIntervalString = "\(minute)分\(seconds)秒"
                        }
                    }else{
                        timeIntervalString = "\(hour)小时\(minute)分\(seconds)秒"
                    }
                }else{
                    timeIntervalString = "\(day)天\(hour)小时\(minute)分\(seconds)秒"
                }
            }else{
                timeIntervalString = "\(month)月\(day)天\(hour)小时\(minute)分\(seconds)秒"
            }
        }else{
            timeIntervalString = "\(year)年\(month)月\(day)天\(hour)小时\(minute)分\(seconds)秒"
        }
        print(timeIntervalString)

    }

    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func storeInfo(theme:String, time:String, timeInterval:String, text:String,isFinish:String){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "TimeTrainInfo", in: context)
        
        let timeTrainInfo = NSManagedObject(entity: entity!, insertInto: context)
        
        timeTrainInfo.setValue(theme, forKey: "theme")
        timeTrainInfo.setValue(time, forKey: "time")
        timeTrainInfo.setValue(timeInterval, forKey: "timeInterval")
        timeTrainInfo.setValue(text, forKey: "text")
        timeTrainInfo.setValue(isFinish, forKey: "isFinish")
        
       
               
      
        
        
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
