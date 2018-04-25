//
//  ViewController.swift
//  DSShareView
//
//  Created by 943147350@qq.com on 04/24/2018.
//  Copyright (c) 2018 943147350@qq.com. All rights reserved.
//

import UIKit
import DSShareView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let shareView = DSShareView()
//        shareView.shareModel.title = "这是标题"
//        shareView.shareModel.descr = "这是描述"
//        shareView.shareModel.url = "这是分享链接"
//        shareView.shareModel.image = UIImage() //这是分享的图片
        shareView.showShareView(with: .DSShareContentTypeText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

