//
//  LocalNotificationUtils.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/3/9.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit

class LocalNotificationUtils: NSObject {
    
    //发送通知消息
    func scheduleNotification(itemID:Int){
        //如果已存在该通知消息，则先取消
        cancelNotification(itemID: itemID)
        
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        
        //推送时间（设置为30秒以后）
        localNotification.fireDate = Date(timeIntervalSinceNow: 30)
        //时区
        localNotification.timeZone = NSTimeZone.default
        //推送内容
        localNotification.alertBody = "来自hangge.com的本地消息"
        //声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //额外信息
        localNotification.userInfo = ["ItemID":itemID]
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    //取消通知消息
    func cancelNotification(itemID:Int){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(itemID: itemID)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.shared.cancelLocalNotification(existingNotification!)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
    func notificationForThisItem(itemID:Int)-> UILocalNotification? {
        let allNotifications = UIApplication.shared.scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:Int]
            let number = info["ItemID"]
            if number != nil && number == itemID {
                return notification as UILocalNotification
            }
        }
        return nil
    }

}
