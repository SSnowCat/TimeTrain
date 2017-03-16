//
//  DetailPillViewView.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/3/16.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit

class DetailPillViewView: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var DetailText: UITextView!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var downView: UIView!
    
    var titletext: String!
    var textDetail:String!
    var time:String!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.layer.cornerRadius = 46
        self.view.alpha = 0.3
        upView.layer.cornerRadius = 46
        downView.layer.cornerRadius = 46
        DetailText.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        titleText.text = titletext
        DetailText.text = textDetail
        timeText.text = time
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
