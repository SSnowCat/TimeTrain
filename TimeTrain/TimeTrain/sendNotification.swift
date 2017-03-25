//
//  sendNotification.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/3/11.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import UserNotifications

class sendNotification: NSObject {
    
    func sendNotificationWithSava(a : Int,str:String){
        
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
            //content.subtitle = NSString.localizedUserNotificationString(forKey: "快来吃药啦", arguments: nil)
            content.subtitle = str
            content.body = NSString.localizedUserNotificationString(forKey: "是时候检查主人的任务完成没有啦", arguments: nil)
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = NotificationType.serviceExtension.rawValue
            
            if let attachment = attachment {
                content.attachments = [attachment]
            }
            return content
        }()
        
        let notificationRequest = UNNotificationRequest(identifier: notificationRequestId, content: notificationContent, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(a), repeats: false))
        center.add(notificationRequest) { (error) in
            if let error = error {
                print("\(error)")
            }
        }
        
        
    }
   
    
    


}
