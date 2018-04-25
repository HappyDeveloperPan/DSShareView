//
//  DSSharePlatform.swift
//  DSShareView
//
//  Created by iOS Pan on 2018/4/24.
//

import UIKit

public enum DSShareType: Int {
    case DSShareTypeWechatSession = 1           //微信好友
    case DSShareTypeWechatTimeline = 2          //微信朋友圈
    case DSShareTypeQQ = 3                      //QQ好友
}

public enum DSShareContentType: Int {
    case DSShareContentTypeText = 1             //文本分享
    case DSShareContentTypeImage = 2            //图片分享
    case DSShareContentTypeLink = 3             //链接分享
}

/// 分享平台Model
public class DSSharePlatform: NSObject {
    var iconStateNormal: String = ""
    var iconStateHighlighted: String = ""
    var name: String = ""
    var shareType: DSShareType?
}

/// 分享平台的协议, 并且指定该协议只可以被QSShareView继承
public protocol LinkPlatformProtocol {
    func shareLinkToPlatform(_ shareModel: DSShareModel, shareType: DSShareType, shareContentType: DSShareContentType)
}

extension LinkPlatformProtocol where Self: DSShareView {
    
    /// 根据自己的分享平台分享内容
    ///
    /// - Parameters:
    ///   - shareModel: 分享平台所需数据类型(比如标题, 图片, 网址...)
    ///   - shareType: 分享的平台
    ///   - shareContentType: 分享的内容类型(文本, 富文本, 网址, APP内容...)
    public func shareLinkToPlatform(_ shareModel: DSShareModel, shareType: DSShareType, shareContentType: DSShareContentType) {
        switch shareType {
        case .DSShareTypeWechatSession:
//            sendMessageToWX(shareModel, bText: false, scene: WXSceneSession)
            break
        case .DSShareTypeWechatTimeline:
//            sendMessageToWX(shareModel, bText: false, scene: WXSceneTimeline)
            break
        default:break
        }
    }
    
    /// 分享到微信(这里使用的是微信原生的分享,根据自己需求编写)
    ///
    /// - Parameters:
    ///   - shareModel: 分享平台所需数据类型(比如标题, 图片, 网址...)
    ///   - bText: 微信字段(是否为富文本)
    ///   - scene: 微信分享类别
//    func sendMessageToWX(_ shareModel: DSShareModel, bText: Bool, scene: WXScene) {
//        let message = WXMediaMessage()
//        message.title = shareModel.title
//        message.description = shareModel.descr
//        message.setThumbImage(UIImage(named: shareModel.image))
//
//        let webPageObject = WXWebpageObject()
//        webPageObject.webpageUrl = shareModel.url
//        message.mediaObject = webPageObject
//
//        let req = SendMessageToWXReq()
//        req.bText = bText
//        req.message = message
//        req.scene = Int32(scene.rawValue)
//
//        WXApi.send(req)
//    }
}
