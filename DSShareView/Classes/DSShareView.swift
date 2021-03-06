//
//  DSShareView.swift
//  DSShareView
//
//  Created by iOS Pan on 2018/4/24.
//

import UIKit

public class DSShareView: UIView, LinkPlatformProtocol {
    // MARK: - 外部属性
    public var shareModel = DSShareModel()

    // MARK: - 静态属性
    /// 屏幕的宽
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    /// 屏幕的高
    let SCREENH_HEIGHT = UIScreen.main.bounds.height
    
    let QSShreButtonHeight: CGFloat = 90.0
    let QSShreButtonWith: CGFloat = 76.0
    let QSShreHeightSpace: CGFloat = 15.0 //竖间距
    let QSShreCancelHeight: CGFloat = (UIScreen.main.bounds.height == 812 ? 80 : 46)
    
    // MARK: - 内部属性
    fileprivate var shareViewHeight: CGFloat = 0 //分享视图高度
    fileprivate var buttonArr = [UIButton]()
    fileprivate var platformArray = [DSSharePlatform]()
    
    fileprivate var shareContentType: DSShareContentType?
    
    // MARK: - 懒加载
    lazy var bottomPopView: UIView = {
        let bottomPopView = UIView(frame: CGRect(x: 0, y:SCREENH_HEIGHT , width: SCREEN_WIDTH, height: self.shareViewHeight))
        bottomPopView.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)
        return bottomPopView
    }()
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setUpPlatformsItems()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.addTarget(self, action: #selector(closeShareView))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        //计算分享视图高度
        shareViewHeight = QSShreHeightSpace * (CGFloat(platformArray.count / 4 + 2)) + QSShreButtonHeight * (CGFloat(platformArray.count / 4 + 1)) + QSShreCancelHeight
        //计算间隙
        let columnCount: Int = 4
        let appMargin = (SCREEN_WIDTH - CGFloat(columnCount) * QSShreButtonWith) / (CGFloat(columnCount) + 1)
        
        for i in 0..<platformArray.count {
            let platform = platformArray[i]
            //计算列号和行号
            let colX: Int = i%columnCount
            let rowY: Int = Int(i/columnCount)
            //计算坐标
            let buttonX: CGFloat = appMargin + CGFloat(colX) * (QSShreButtonWith + appMargin)
            let buttonY: CGFloat = QSShreHeightSpace + CGFloat(rowY) * (QSShreButtonHeight + QSShreHeightSpace)
            let shareBtn = DSShareButton()
            shareBtn.setTitle(platform.name, for: .normal)
            shareBtn.setImage(UIImage(contentsOfFile: platform.iconStateNormal), for: .normal)
            shareBtn.setImage(UIImage(contentsOfFile: platform.iconStateHighlighted), for: .highlighted)
            shareBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
            shareBtn.tag = platform.shareType!.rawValue
            shareBtn.frame = CGRect(x: buttonX, y: buttonY, width: QSShreButtonWith, height: QSShreButtonHeight)
            self.bottomPopView.addSubview(shareBtn)
            self.buttonArr.append(shareBtn)
        }
        //按钮动画
        for button in buttonArr {
            let index = buttonArr.index(of: button)
            
            let fromTransform = CGAffineTransform(translationX: 0, y: 50)
            button.transform = fromTransform
            button.alpha = 0.3
            
            UIView.animate(withDuration: TimeInterval(0.9+Float(index!)*0.1), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                button.transform = CGAffineTransform.identity
                button.alpha = 1
            }, completion: nil)
        }
        //取消按钮
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.frame = CGRect(x: 0, y: shareViewHeight - QSShreCancelHeight, width: SCREEN_WIDTH, height: QSShreCancelHeight)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.black, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.addTarget(self, action: #selector(closeShareView), for: .touchUpInside)
        self.bottomPopView.addSubview(cancelBtn)
        
        self.addSubview(self.bottomPopView)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 交互处理
    /// 初始化分享平台
    func setUpPlatformsItems() {
        //要先行判断是否安装有微信
//        if UIApplication.shared.canOpenURL(URL(string: "weixin://")!){
            let wechatSessionModel = DSSharePlatform()
            wechatSessionModel.iconStateNormal = imagePath(with: "weixin_allshare_60x60_@2x")
            wechatSessionModel.iconStateHighlighted = imagePath(with: "weixin_allshare_night_60x60_@2x")
            wechatSessionModel.shareType = DSShareType.DSShareTypeWechatSession
            wechatSessionModel.name = "微信好友"
            platformArray.append(wechatSessionModel)
            
            let wechatTimeLineModel = DSSharePlatform()
            wechatTimeLineModel.iconStateNormal = imagePath(with: "pyq_allshare_60x60_@2x")
            wechatTimeLineModel.iconStateHighlighted = imagePath(with: "pyq_allshare_night_60x60_@2x")
            wechatTimeLineModel.shareType = DSShareType.DSShareTypeWechatTimeline
            wechatTimeLineModel.name = "朋友圈"
            platformArray.append(wechatTimeLineModel)
//        }
        
    }
    
    /// 分享视图展示
    ///
    /// - Parameters:
    ///   - shareModel: 分享数据
    ///   - shareContentType: 分享类型
    public func showShareView(with shareContentType: DSShareContentType) {
//        self.shareModel = shareModel
        self.shareContentType = shareContentType
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.clear
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self?.bottomPopView.frame = CGRect(x: 0,
                                               y: ((self?.SCREENH_HEIGHT)!) - ((self?.shareViewHeight)!),
                                               width: (self?.SCREEN_WIDTH)!,
                                               height: (self?.shareViewHeight)!)
        }
    }
    
    /// 分享按钮点击
    ///
    /// - Parameter sender: 分享按钮
    @objc func shareBtnClick(_ sender: UIButton) {
        shareLinkToPlatform(shareModel,
                            shareType: DSShareType(rawValue: sender.tag)!,
                            shareContentType: .DSShareContentTypeLink)
        closeShareView()
    }
    
    /// 关闭视图
    @objc func closeShareView() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.backgroundColor = UIColor.clear
            self?.bottomPopView.frame = CGRect(x: 0,
                                               y: (self?.SCREENH_HEIGHT)!,
                                               width: (self?.SCREEN_WIDTH)!,
                                               height: (self?.shareViewHeight)!)
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    func imagePath(with imageName: String) -> String {
        let bundle = Bundle(for: DSShareView.self)
        let path = bundle.path(forResource: imageName, ofType: "png", inDirectory: "DSShareView.bundle")
        if let path = path {
            return path
        }else {
            return ""
        }
    }

}

// MARK: - UIGestureRecognizer代理
extension DSShareView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.bottomPopView))! {
            return false
        }
        return true
    }
}
