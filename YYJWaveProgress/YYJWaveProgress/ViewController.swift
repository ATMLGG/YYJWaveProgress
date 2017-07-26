//
//  ViewController.swift
//  YYJWaveProgress
//
//  Created by yyj on 2017/7/21.
//  Copyright © 2017年 yyj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var github: YYJWaveProgress!
    @IBOutlet weak var twitter: YYJWaveProgress!
    @IBOutlet weak var wechat:YYJWaveProgress!
    @IBOutlet weak var sina:YYJWaveProgress!
    @IBOutlet weak var progress: YYJWaveProgress!
    
    var link:CADisplayLink?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //如果视图不是正方形,进度动画会位于视图中心
        
        github.waveSpeed = 5
        github.waveHeight = 3
        github.waveColor = UIColor.purple
        github.imageV?.image = #imageLiteral(resourceName: "github.png")
        github.completionHandle = {
            print("100%");
        }
        
        self.view.addSubview(github)
        
        
        twitter.waveSpeed = 5
        twitter.waveHeight = 3
        twitter.waveColor = UIColor.init(red: 26/255.0, green: 178/255.0, blue: 232/255.0, alpha: 1)
        twitter.imageV?.image = #imageLiteral(resourceName: "twitter.png")
        twitter.completionHandle = {
            print("100%");
        }
        
        self.view.addSubview(twitter)

        
        wechat.waveSpeed = 5
        wechat.waveHeight = 3
        wechat.waveColor = UIColor.green
        wechat.imageV?.image = #imageLiteral(resourceName: "wechat.png")
        wechat.completionHandle = {
            print("100%");
        }
        
        self.view.addSubview(wechat)
        
        
        sina.waveSpeed = 5
        sina.waveHeight = 3
        sina.waveColor = UIColor.orange
        sina.imageV?.image = #imageLiteral(resourceName: "sina.png")
        sina.completionHandle = {
            print("100%");
        }
        
        self.view.addSubview(sina)
        
        
        progress.mProgressType = ProgressType.ShowPercent
        progress.waveColor = UIColor.black
        progress.completionHandle = {
            print("100%")
        }
        self.view.addSubview(progress)
        
        
        
        
        
        link = CADisplayLink.init(target: self, selector: #selector(self.setProgress))
        link?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        link?.isPaused = false

    }

    func setProgress() {
        
        if progress.progress <= CGFloat(1) {
            github.progress += 0.001
            twitter.progress += 0.001
            wechat.progress += 0.001
            sina.progress += 0.001
            progress.progress += 0.001
        } else {
            link?.isPaused = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

