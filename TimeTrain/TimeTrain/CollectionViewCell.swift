//
//  CollectionViewCell.swift
//  TimeTrain
//
//  Created by SnowBaby on 2017/3/4.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.layer.cornerRadius = 46
        
    }
    

}
