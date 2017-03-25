//
//  AppDelegate.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/2/20.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let view = window?.rootViewController?.view
        view?.backgroundColor = UIColor(patternImage: UIImage(named: "底.png")!)
        registorForNotifications()
        
       
        return true
    }
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TimeTrain")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

extension AppDelegate {
    
    
    func registorForNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        center.delegate = self
        
        let actionWaddup = UNNotificationAction(identifier: ActionType.waddup.rawValue, title: "Waddup", options: [.foreground])
        let actionHolla = UNNotificationAction(identifier: ActionType.holla.rawValue, title: "Holla", options: [.foreground])
        let actionYo = UNNotificationAction(identifier: ActionType.yo.rawValue, title: "Yo", options: [.foreground])
        let actionWord = UNNotificationAction(identifier: ActionType.word.rawValue, title: "Word", options: [.foreground])
        let actionSup = UNNotificationAction(identifier: ActionType.sup.rawValue, title: "Sup", options: [.foreground])
        let actions = [actionWaddup, actionHolla, actionYo, actionWord, actionSup]
        let categoryOptions = UNNotificationCategoryOptions(rawValue: 0)
        //<<<<<<< HEAD
        //        let plainCategory = UNNotificationCategory(identifier: NotificationType.plain.rawValue, actions: [actionWaddup], intentIdentifiers: [], options: categoryOptions)
        //        let serviceExtensionCategory = UNNotificationCategory(identifier: NotificationType.serviceExtension.rawValue, actions: [actionWaddup], intentIdentifiers: [], options: categoryOptions)
        //        let contentExtensionCategory = UNNotificationCategory(identifier: NotificationType.contentExtension.rawValue, actions: [actionWaddup], intentIdentifiers: [], options: categoryOptions)
        //        center.setNotificationCategories(Set([plainCategory, serviceExtensionCategory, contentExtensionCategory]))
        //=======
        let plainCategory = UNNotificationCategory(identifier: NotificationType.plain.rawValue, actions: actions, intentIdentifiers: [], options: categoryOptions)
        let serviceExtensionCategory = UNNotificationCategory(identifier: NotificationType.serviceExtension.rawValue, actions: actions, intentIdentifiers: [], options: categoryOptions)
        let contentExtensionCategory = UNNotificationCategory(identifier: NotificationType.contentExtension.rawValue, actions: actions, intentIdentifiers: [], options: categoryOptions)
        let animatedContentExtensionCategory = UNNotificationCategory(identifier: NotificationType.animatedContentExtension.rawValue, actions: actions, intentIdentifiers: [], options: categoryOptions)
        center.setNotificationCategories(Set([plainCategory, serviceExtensionCategory, contentExtensionCategory, animatedContentExtensionCategory]))
        //>>>>>>> a126a57... Exercise capabilities
        
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "主人，该吃药啦！", message: "你的任务完成了吗？", preferredStyle: UIAlertControllerStyle.alert)
        let view = self.window?.rootViewController
        print("收到响应")
        print(response.notification.request.content.subtitle)
        print("收到回应")
        
        
        let finishAction = UIAlertAction(title: "完成啦", style: .default) { (UIAlertAction) -> Void in
            let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AnimationView")
            view?.present(viewController, animated: true, completion:nil)
            let time: TimeInterval = 10.0
            let content = self.getContext()
            let conditionl = response.notification.request.content.subtitle
            let condition = "theme=\(conditionl)"
            let predicate = NSPredicate(format: condition, "")
            let entity = NSEntityDescription.entity(forEntityName: "TimeTrainInfo", in: content)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeTrainInfo")
            fetchRequest.predicate = predicate
            fetchRequest.entity = entity
            do {
                
                let searchResults = try self.getContext().fetch(fetchRequest) as! [TimeTrainInfo] as NSArray
                if searchResults.count != 0 {
                    let timeTrain = searchResults[0] as! TimeTrainInfo
                    timeTrain.isFinish = "1"
                    try content.save()
                    print("fix success")
                }else{
                    print("fix faild")
                }
                
            }catch  {
                print(error)
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                //code
                
                print("10 秒后输出")
                view?.dismiss(animated: true, completion:nil)
            }
        }
        let notFinishAction = UIAlertAction(title: "没有完成", style: .default, handler: nil)
        
        alertController.addAction(finishAction)
        alertController.addAction(notFinishAction)
        
               view?.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}




