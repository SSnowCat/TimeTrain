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
        dataLabel.text = pillmodel.time
        context.isUserInteractionEnabled = false
        
        if pillmodel.isfinish == "0" {
            isFinishImage.image = #imageLiteral(resourceName: "完成的")
        }else{
            isFinishImage.image = #imageLiteral(resourceName: "完成部分的")
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
