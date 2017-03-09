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
            
            let url:URL
            url = MediaType.audioFullLocal.url()
            
            let attachment: UNNotificationAttachment?
            do {
                
                attachment = try UNNotificationAttachment(identifier: notificationAttachmentId, url: url, options: nil)
            } catch {
                attachment = nil
            }
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Here come dat boi!", arguments: nil)
            content.subtitle = NSString.localizedUserNotificationString(forKey: "Subtitle", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Oh snap!", arguments: nil)
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
    
    
    
    
}

