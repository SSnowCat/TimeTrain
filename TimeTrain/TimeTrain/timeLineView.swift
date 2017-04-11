//
//  timeLineView.swift
//  TimeLineDemo
//
//  Created by SnowBaby on 2017/4/11.
//  Copyright © 2017年 SnowBaby. All rights reserved.
//

import UIKit

class timeLineView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     
     /**主题*/
     var title:String?
     /**时间*/
     var timeInterval:String?
     /**完成时间*/
     var time:String?
     /**详细内容*/
     var detail:String?
     /**是否完成*/
     var isfinish:String?
     
     */
    
    var modelArray:[pillModel] = []
    var WIDTH = 374.0
    var HEIGHT = 736.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        //绘制中间的竖线
        let ctf = UIGraphicsGetCurrentContext()
        ctf?.setLineWidth(1)
        ctf?.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)
        var aPoints:[CGPoint] = []
        let point1 = CGPoint(x: WIDTH/2, y: 80)
        let point2 = CGPoint(x: WIDTH/2, y: Double(modelArray.count)*80.0)
        aPoints.append(point1)
        aPoints.append(point2)
        ctf?.addLines(between: aPoints)
        ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
        //绘制最上面的原点
        ctf?.addArc(center: aPoints[0], radius: 4, startAngle: 0, endAngle: CGFloat(2.0*M_PI), clockwise: false)
        ctf?.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
        
        //绘制最下面的原点
        ctf?.addArc(center: aPoints[1], radius: 4, startAngle: 0, endAngle: CGFloat(2.0*M_PI), clockwise: false)
        ctf?.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
        ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
        
        //绘制中线上的原点和链接线
        for i in 0..<modelArray.count {
            let model:pillModel = modelArray[i]
            var startPoint:CGPoint
            var endPoint:CGPoint
            
            if i%2 == 0  {
                ctf?.move(to: CGPoint(x: WIDTH/2, y: Double(i)*60.0+80))
                ctf?.addLine(to: CGPoint(x: WIDTH/2-(WIDTH/2 - 50.0), y: 80.0+60.0*Double(i)))
                ctf?.setFillColor(red: 125, green: 0, blue: 0, alpha: 1)
                ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
                
                startPoint = CGPoint(x: WIDTH/2, y: 80.0+60.0*Double(i))
                
                endPoint = CGPoint(x: WIDTH/2 - (WIDTH/2 - 50), y: 80 + 60 * Double(i))
                //绘制末尾圆点后的图片
                let image = UIImageView(frame: CGRect(x: endPoint.x - 20, y: endPoint.y - 8 , width: 15, height: 15))
                image.image = UIImage(named: "图标.png")
                self.addSubview(image)
                //标题
                if !(model.title?.isEmpty)! {
                    let addressView = UIImageView(frame: CGRect(x: endPoint.x-20.0, y: endPoint.y+20, width: 15, height: 15))
                    addressView.image = UIImage(named: "address.png")
                    self.addSubview(addressView)
                    let addressLabel = UILabel(frame: CGRect(x: addressView.frame.maxX+5, y: endPoint.y+20, width: CGFloat(WIDTH/2), height: 20.0))
                    addressLabel.text = model.title!
                    addressLabel.sizeToFit()
                    self.addSubview(addressLabel)
                    
                }
                //是否完成
                if !model.title!.isEmpty && !model.timeInterval!.isEmpty {
                    let motiveImage = UIImageView(frame: CGRect(x: endPoint.x-20.0, y: endPoint.y+40, width: 15, height: 15))
                    motiveImage.image = UIImage(named: "message.png")
                    self.addSubview(motiveImage)
                    let motiveLabel = UILabel(frame: CGRect(x: motiveImage.frame.maxX + 5, y: endPoint.y+40, width: CGFloat(WIDTH/2), height: 20.0))
                    motiveLabel.text = model.timeInterval
                    motiveLabel.sizeToFit()
                    self.addSubview(motiveLabel)
                    
                }else if !model.timeInterval!.isEmpty {
                    let motiveImage = UIImageView(frame: CGRect(x: endPoint.x-20.0, y: endPoint.y+40, width: 15, height: 15))
                    motiveImage.image = UIImage(named: "message.png")
                    self.addSubview(motiveImage)
                    let motiveLabel = UILabel(frame: CGRect(x: motiveImage.frame.maxX + 5, y: endPoint.y+40, width: CGFloat(WIDTH/2), height: 20.0))
                    motiveLabel.text = model.timeInterval
                    motiveLabel.sizeToFit()
                    self.addSubview(motiveLabel)
                }
                //时间
                if model.title!.isEmpty && model.timeInterval!.isEmpty && !model.time!.isEmpty {
                    
                    let dateImage = UIImageView(frame: CGRect(x: endPoint.x - 20, y: endPoint.y + 20, width: 15, height: 15))
                    dateImage.image = UIImage(named: "book.png")
                    self.addSubview(dateImage)
                    let dateLabel = UILabel(frame: CGRect(x:dateImage.frame.maxX + 5 , y: endPoint.y + 20, width: CGFloat(WIDTH/2), height: 20.0))
                    dateLabel.text = model.time
                    dateLabel.sizeToFit()
                    self.addSubview(dateLabel)
                    
                }else if model.title!.isEmpty && !model.timeInterval!.isEmpty && !model.time!.isEmpty {
                    let dateImage = UIImageView(frame: CGRect(x: endPoint.x - 20, y: endPoint.y + 40, width: 15, height: 15))
                    dateImage.image = UIImage(named: "book.png")
                    self.addSubview(dateImage)
                    let dateLabel = UILabel(frame: CGRect(x:dateImage.frame.maxX + 5 , y: endPoint.y + 20, width: CGFloat(WIDTH/2), height: 40.0))
                    dateLabel.text = model.time
                    dateLabel.sizeToFit()
                    self.addSubview(dateLabel)
                }else if !model.time!.isEmpty && !model.timeInterval!.isEmpty && !model.time!.isEmpty {
                    let dateImage = UIImageView(frame: CGRect(x: endPoint.x - 20, y: endPoint.y + 60, width: 15, height: 15))
                    dateImage.image = UIImage(named: "book.png")
                    self.addSubview(dateImage)
                    let dateLabel = UILabel(frame: CGRect(x:dateImage.frame.maxX + 5 , y: endPoint.y + 60, width: CGFloat(WIDTH/2), height: 20.0))
                    dateLabel.text = model.time
                    dateLabel.sizeToFit()
                    dateLabel.textColor = UIColor.gray
                    dateLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    self.addSubview(dateLabel)
                }
                
                
                
                
            }else{
                ctf?.move(to: CGPoint(x: WIDTH/2, y: 80.0+Double(i)*60.0))
                ctf?.addLine(to: CGPoint(x: WIDTH/2+(WIDTH/2-50), y: 80.0+Double(i)*60.0))
                ctf?.setLineWidth(1)
                ctf?.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)
                ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
                
                startPoint = CGPoint(x: WIDTH/2, y: 80.0+60.0*Double(i))
                
                endPoint = CGPoint(x: WIDTH/2 + (WIDTH/2 - 50), y: 80 + 60 * Double(i))
                //绘制末尾圆点后的图片
                let image = UIImageView(frame: CGRect(x: endPoint.x+5, y: endPoint.y - 8, width: 15, height: 15))
                image.image = UIImage(named: "图标.png")
                self.addSubview(image)
                //地址
                if !model.title!.isEmpty {
                    let addressView = UIImageView(frame: CGRect(x: startPoint.x+20, y: endPoint.y+30, width: 15, height: 15))
                    addressView.image = UIImage(named: "address.png")
                    self.addSubview(addressView)
                    let addressLabel = UILabel(frame: CGRect(x: addressView.frame.maxX+5, y: endPoint.y+30, width: CGFloat(WIDTH/2), height: 20.0))
                    addressLabel.text = model.title
                    addressLabel.sizeToFit()
                    self.addSubview(addressLabel)
                    
                }
                //目的
                if  !model.title!.isEmpty && !model.timeInterval!.isEmpty  {
                    let motiveImage = UIImageView(frame: CGRect(x: startPoint.x+20.0, y: endPoint.y+50, width: 15, height: 15))
                    motiveImage.image = UIImage(named: "message.png")
                    self.addSubview(motiveImage)
                    let motiveLabel = UILabel(frame: CGRect(x: motiveImage.frame.maxX + 5, y: endPoint.y+50, width: CGFloat(WIDTH/2), height: 20.0))
                    motiveLabel.text = model.timeInterval
                    motiveLabel.sizeToFit()
                    self.addSubview(motiveLabel)
                    
                }else if !model.timeInterval!.isEmpty {
                    let motiveImage = UIImageView(frame: CGRect(x: startPoint.x-20.0, y: endPoint.y+50, width: 15, height: 15))
                    motiveImage.image = UIImage(named: "message.png")
                    self.addSubview(motiveImage)
                    let motiveLabel = UILabel(frame: CGRect(x: motiveImage.frame.maxX + 5, y: endPoint.y+50, width: CGFloat(WIDTH/2), height: 20.0))
                    motiveLabel.text = model.timeInterval
                    motiveLabel.sizeToFit()
                    self.addSubview(motiveLabel)
                }
                //时间
                if  model.title!.isEmpty && model.timeInterval!.isEmpty && !model.time!.isEmpty {
                    
                    let dateImage = UIImageView(frame: CGRect(x: startPoint.x + 20, y: endPoint.y + 20, width: 15, height: 15))
                    dateImage.image = UIImage(named: "book.png")
                    self.addSubview(dateImage)
                    let dateLabel = UILabel(frame: CGRect(x:dateImage.frame.maxX + 5 , y: endPoint.y + 20, width: CGFloat(WIDTH/2), height: 20.0))
                    dateLabel.text = model.time
                    dateLabel.sizeToFit()
                    self.addSubview(dateLabel)
                    
                }else if model.title!.isEmpty && !model.timeInterval!.isEmpty && !model.time!.isEmpty {
                    let dateImage = UIImageView(frame: CGRect(x: startPoint.x + 20, y: endPoint.y + 50, width: 15, height: 15))
                    dateImage.image = UIImage(named: "book.png")
                    self.addSubview(dateImage)
                    let dateLabel = UILabel(frame: CGRect(x:dateImage.frame.maxX + 5 , y: endPoint.y + 50, width: CGFloat(WIDTH/2), height: 40.0))
                    dateLabel.text = model.time
                    dateLabel.sizeToFit()
                    self.addSubview(dateLabel)
                }else if !model.time!.isEmpty && !model.timeInterval!.isEmpty && !model.time!.isEmpty{
                    let dateImage = UIImageView(frame: CGRect(x: startPoint.x + 20, y: endPoint.y + 70, width: 15, height: 15))
                    dateImage.image = UIImage(named: "book.png")
                    self.addSubview(dateImage)
                    let dateLabel = UILabel(frame: CGRect(x:dateImage.frame.maxX + 5 , y: endPoint.y + 70, width: CGFloat(WIDTH/2), height: 20.0))
                    dateLabel.text = model.time
                    dateLabel.sizeToFit()
                    dateLabel.textColor = UIColor.gray
                    dateLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    self.addSubview(dateLabel)
                }
                
                
            }
            //绘制末尾的圆点
            ctf?.addArc(center: endPoint, radius: 2, startAngle: 0, endAngle:CGFloat(2*M_PI), clockwise: false)
            ctf?.setFillColor(UIColor.red.cgColor)
            ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
            //绘制中线上的原点
            ctf?.addArc(center: CGPoint(x:WIDTH/2,y:Double(i)*60.0+80) , radius: 4, startAngle: 0, endAngle:CGFloat(2*M_PI), clockwise: false)
            ctf?.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
            ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
            
            //绘制中线上的原点内的小圆点
            ctf?.addArc(center: CGPoint(x:WIDTH/2,y:Double(i)*60.0+80) , radius: 3, startAngle: 0, endAngle:CGFloat(2*M_PI), clockwise: false)
            ctf?.setFillColor(red: 1, green: 1, blue: 1, alpha: 1)
            ctf?.drawPath(using: CGPathDrawingMode.eoFillStroke)
            
            
            
            
            
        }
        
        
    }
}
