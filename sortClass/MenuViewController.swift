//
//  MenuViewController.swift
//  sortClass
//
//  Created by vincent on 15/5/5.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadBackgroud();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - background
    
    /**
        初始化背景图片
    */
    func loadBackgroud()
    {
        var bkImg = UIImage(named: "mainBK")?.CGImage;
        self.view.layer.contents = bkImg;
//        var backgroudImg:UIColor = UIColor()
//        self.view.backgroundColor = UIColor
    }
}
