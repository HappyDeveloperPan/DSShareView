//
//  QSShareModel.swift
//  DSShareView
//
//  Created by iOS Pan on 2018/4/24.
//

import UIKit

public class DSShareModel: NSObject {
    /// 分享标题
    public var title: String = ""
    ///描述内容
    public var descr: String = ""
    ///缩略图
    public var image: UIImage = UIImage()
    ///链接
    public var url: String = ""
}
