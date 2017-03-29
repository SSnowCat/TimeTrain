//
//  ViewController.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/2/20.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBAction func cancel(segue:UIStoryboardSegue){
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //推送通知不带铃声
    @IBAction func sendNotification(_ sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        
        let notificationRequestId = "notificationRequestId"
        let notificationContent = { () -> UNMutableNotificationContent in
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "你的药到了!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "主人，你的胶囊到了！赶快吃吧！!", arguments: nil)
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = NotificationType.plain.rawValue
            return content
        }()
        
        let notificationRequest = UNNotificationRequest(identifier: notificationRequestId, content: notificationContent, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false))
        center.add(notificationRequest) { (error) in
            if let error = error {
                print("\(error)")
            }
        }
    }
    //推送通知带铃声
    @IBAction func sendNotificationWithAttachment(_ sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        
        let notificationRequestId = "notificationRequestId"
        let notificationAttachmentId = "notificationAttachmentId"
        
        let notificationContent = { () -> UNMutableNotificationContent in
            
            let url = URL(fileURLWithPath: "testing.m4a")
            
            let attachment: UNNotificationAttachment?
            do {
                
                attachment = try UNNotificationAttachment(identifier: notificationAttachmentId, url: url, options: nil)
            } catch {
                attachment = nil
            }
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "你的药到了!", arguments: nil)
            content.subtitle = NSString.localizedUserNotificationString(forKey: "快来吃药啦", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "是时候检查主人的任务完成没有啦", arguments: nil)
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = NotificationType.serviceExtension.rawValue
            if let attachment = attachment {
                content.attachments = [attachment]
            }
            return content
        }()
        
        let notificationRequest = UNNotificationRequest(identifier: notificationRequestId, content: notificationContent, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false))
        center.add(notificationRequest) { (error) in
            if let error = error {
                print("\(error)")
            }
        }
    }
    
    @IBAction func animationFunc(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AnimationView")
        self.present(viewController, animated: true, completion:nil)
        let time: TimeInterval = 10.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            print("10 秒后输出")
            self.dismiss(animated: true, completion:nil)
        }
        
       
    }
    @IBAction func testalert(_ sender: Any) {
        
        ZuberAlert().showAlert("小提示", subTitle: "这是一个测试的小提示", buttonTitle: "取消", otherButtonTitle: "确认") { (OtherButton) -> Void in
            print("执行了确认")
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            //code
            print("10 秒后输出")
            self.dismiss(animated: true, completion:nil)
        }

    }
    
  


}



