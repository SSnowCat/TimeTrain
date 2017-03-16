//
//  secondView.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/2/23.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit
import CoreData
var myPillCollectionView:UICollectionView?
class secondView: UIViewController,UIGestureRecognizerDelegate {

    
   
    var searchResults:[Any] = []
    var detailView:DetailPillViewView? = nil
    var dataSource = NSMutableArray()
    @IBAction func cancelToCreateTrain(segue:UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "底.png")!)
        
        
        DispatchQueue.global().async {
            
           
            
            // 主线程异步执行（主线程同步可能会死锁）
            DispatchQueue.main.async(execute: {
                self.getInfo()
                myPillCollectionView?.reloadData()
            })
        }
       
        
        createPillCollectionView()

        // Do any additional setup after loading the view.
    }
    let freshData:()->Bool = {
        return ((myPillCollectionView?.reloadData()) != nil)
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
                let str1 = swStr.substring(with: NSMakeRange(9, 8))
                model.detail = p.value(forKey: "text") as! String?
                model.time = str1
                self.dataSource.add(model)
                
            }
            
        } catch  {
            print(error)
        }
        
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
    }
   
    
    func createPillCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10.0
        myPillCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:flowLayout)
        myPillCollectionView?.dataSource = self
        myPillCollectionView?.delegate = self
        myPillCollectionView?.backgroundColor = UIColor.white
        myPillCollectionView?.backgroundColor? = UIColor(patternImage: UIImage(named: "底.png")!)
        self.view.addSubview(myPillCollectionView!)
        self.view.sendSubview(toBack: myPillCollectionView!)
        
        
        
        let nib = UINib(nibName:"CollectionViewCell",bundle:nil)
        myPillCollectionView?.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
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

extension secondView:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    //return the number of block
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setNeedsLayout()
        let model = dataSource.object(at: indexPath.item) as! pillModel
        
        
        cell.timeLabel.text = model.time
        cell.titleLabel.text = model.title
        
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.3
        cell.backgroundColor = UIColor.lightGray
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 121, height: 180)
    }
    
    //set value to label from model
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 46
        cell.backgroundColor = UIColor.yellow
        let model = dataSource.object(at: indexPath.item) as! pillModel
        detailView = DetailPillViewView()
        detailView?.titletext = model.title
        detailView?.textDetail = model.detail
        detailView?.time = model.time
        detailView?.view.frame = CGRect(x: 10, y: 50, width: 240, height: 400)
        detailView?.view.alpha = 0.9
  
        
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissDetailView))
        swipeGesture.delegate = self
        swipeGesture.direction = UISwipeGestureRecognizerDirection.up
        detailView?.view.isUserInteractionEnabled = true
        detailView?.view.addGestureRecognizer(swipeGesture)
        self.view.addSubview((detailView?.view)!)
        
        

        
    }
    func dismissDetailView(sender:UITapGestureRecognizer){
        detailView?.dismiss(animated: true, completion: nil)
        detailView?.view.removeFromSuperview()
        detailView?.removeFromParentViewController()
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: detailView?.view)
        if ((detailView?.view.frame)?.contains(touchPoint))!{
            return true
        }else{
            return true
        }
    }
    
    
    
    

    
    
    
}




