//
//  YYJWaveProgress.swift
//  YYJWaveProgress
//
//  Created by yyj on 2017/7/21.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

typealias CompletionHandle = (Void)->Void

enum ProgressType {
    case ShowPercent//显示当前百分比
    case NoPercent//不显示百分比
}

class YYJWaveProgress: UIView {
    
    //一层波浪
    private var mWaveLayerFir = CAShapeLayer()
    private var mWavePathFir = UIBezierPath()
    //二层波浪
    private var mWaveLayerSec = CAShapeLayer()
    private var mWavePathSec = UIBezierPath()
    
    private var waveHeightOffset:CGFloat?
    private var offset:CGFloat = 0.0
    
    //显示类型
    var mProgressType:ProgressType? = .NoPercent {
        willSet {
        
            if newValue == ProgressType.ShowPercent {
                
                percentLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: min(frame.size.width, frame.size.height), height: min(frame.size.width, frame.size.height)))
                percentLabel?.center = CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2)
                percentLabel?.textAlignment = .center
                percentLabel?.text = "0%"
                percentLabel?.font = UIFont.systemFont(ofSize: 20)
                
                self.addSubview(percentLabel!)
            }
        }
    }
    
    //波浪前进速度 默认5
    var waveSpeed:CGFloat? = 5
    
    //波浪高度 默认4
    var waveHeight:CGFloat? = 4
    
    //显示当前百分比
    var progress:CGFloat = 0.0 {
        didSet {
            if self.mProgressType == ProgressType.ShowPercent {
                percentLabel?.textColor = UIColor.init(white: progress*1.6, alpha: 1)
                percentLabel?.text = "\(Int(progress*100))"+"%"
            }
            
            waveStart()
        }
    }
    
    //波浪颜色,I 艾玛 blue
    var waveColor:UIColor? = UIColor.blue
    //边框颜色,默认颜色比较cool~
    var lineColor:UIColor? = UIColor.init(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
    
    //百分比数字
    var percentLabel:UILabel?
    
    //如果需要自定义边框形状,可传入points数组
    //UNDO
    
    //使用中空图片
    var imageV:UIImageView?
    
    
    var completionHandle:CompletionHandle?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        waveHeightOffset = min(frame.size.width, frame.size.height)
        
        drawBorderLine()
    
        
        imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: min(frame.size.width, frame.size.height), height: min(frame.size.width, frame.size.height)))
        self.addSubview(imageV!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        waveHeightOffset = min(frame.size.width, frame.size.height)
        
        drawBorderLine()
        
        
        imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: min(frame.size.width, frame.size.height), height: min(frame.size.width, frame.size.height)))
        self.addSubview(imageV!)
        
    }
    
    
    func drawBorderLine() {
        
        self.backgroundColor = UIColor.white
        
        self.bounds = CGRect.init(x: 0, y: 0, width: min(frame.size.width, frame.size.height), height: min(frame.size.width, frame.size.height))
        self.layer.cornerRadius = min(frame.size.width, frame.size.height) * 0.5
        self.layer.masksToBounds = true
        self.layer.borderColor = lineColor!.cgColor
        self.layer.borderWidth = 3.0
        
        self.layer.addSublayer(mWaveLayerFir)
        self.layer.addSublayer(mWaveLayerSec)
        
    }
    
    func setup() {
        
        self.layer.borderColor = lineColor?.cgColor
        
        mWaveLayerFir.fillColor = waveColor?.cgColor
        mWaveLayerFir.lineCap = kCALineCapRound
        mWavePathFir.lineCapStyle = CGLineCap.round
        
        
        mWaveLayerSec.fillColor = waveColor?.withAlphaComponent(0.3).cgColor
        mWaveLayerSec.lineCap = kCALineCapRound
        mWavePathSec.lineCapStyle = CGLineCap.round
        
    }
    
    func waveStart() {

        setup()
        
        offset += waveSpeed!
        
        mWavePathFir.removeAllPoints()
        mWavePathFir.move(to: CGPoint.init(x: 0, y: self.frame.size.height))
        //正弦坐标
        for i in 0...Int(self.frame.size.width-1) {
            
            let x = Double.pi*Double(i)/Double(self.frame.size.width)*2
            let y = Double(offset)*Double.pi/Double(self.frame.size.width)
            let z = waveHeight!*CGFloat(sinf(Float(x+y))) + waveHeightOffset!*(1-progress)
            mWavePathFir.addLine(to: CGPoint(x: CGFloat(i), y: CGFloat(z)))
        }
        mWavePathFir.addLine(to: CGPoint.init(x: self.frame.size.width, y: self.frame.size.height))
        mWaveLayerFir.path = mWavePathFir.cgPath
        
        
        mWavePathSec.removeAllPoints()
        mWavePathSec.move(to: CGPoint.init(x: 0, y: self.frame.size.height))
        
        for i in 0...Int(self.frame.size.width-1) {
            
            let x = Double.pi*Double(i)/Double(self.frame.size.width)*2
            let y = Double(offset)*Double.pi/Double(self.frame.size.width)
            let z = waveHeight!*CGFloat(sinf(Float(x+y+Double.pi/2))) + waveHeightOffset!*(1-progress)
            mWavePathSec.addLine(to: CGPoint(x: CGFloat(i), y: CGFloat(z)))
        }
        
        mWavePathSec.addLine(to: CGPoint.init(x: self.frame.size.width, y: self.frame.size.height))
        mWaveLayerSec.path = mWavePathSec.cgPath
        
        if progress > CGFloat(1) {
            completionHandle?()
        }
        
    }
    
    
    
    
}
