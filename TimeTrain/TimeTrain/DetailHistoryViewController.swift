//
//  DetailHistoryViewController.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/3/16.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit

class DetailHistoryViewController: UIViewController {

    @IBOutlet weak var titlteLabel: UILabel!
    @IBOutlet weak var context: UITextView!
    @IBOutlet weak var isFinishImage: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    
    var pillmodel = pillModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "底.png")!)
        titlteLabel.text = pillmodel.title
        context.text = pillmodel.detail
        context.frame = CGRect(x: 60, y: 60, width: 223, height: 361)
        context.layer.cornerRadius = 30
        context.textContainerInset = UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10)
        context.layer.backgroundColor = UIColor.clear.cgColor
        context.backgroundColor = UIColor(patternImage: UIImage(named: "textfiled.png")!)
        dataLabel.text = pillmodel.time
        context.isUserInteractionEnabled = false
        
        if pillmodel.isfinish == "0" {
            isFinishImage.image = #imageLiteral(resourceName: "nofinshed")
        }else{
            isFinishImage.image =  #imageLiteral(resourceName: "finish")
        }
        

        // Do any additional setup after loading the view.
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
