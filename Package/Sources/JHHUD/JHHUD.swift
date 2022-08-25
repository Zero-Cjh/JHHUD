//
//  JHHUD.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/5.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import UIKit

@objc public enum JHHUDType: NSInteger {
    /// Loading动画
    case Loading
    /// 成功
    case Success
    /// 失败
    case Fail
}

/// HUD快捷单例
public let JHHUDManager = JHHUD.Manager

@objc public class JHHUD: NSObject {
    
    // MARK: - Public
    
    /// 单例
    @objc public static let `Manager` = JHHUD.init()
    
    // MARK: - Property
    
    /// 字体颜色
    @objc public var fontColor: UIColor {
        get {
            return self.mainView.fontColor
        }
        set {
            self.mainView.fontColor = newValue
        }
    }
    
    /// 背景色
    @objc public var backgroundColor: UIColor {
        get {
            return self.mainView.backgroundViewColor
        }
        set {
            return self.mainView.backgroundViewColor = newValue
        }
    }
    
    /// 用户是否可以交互
    @objc public var isUserInteractionEnable: Bool {
        get {
            return self.mainView.isUserInteractionEnabled
        }
        set {
            self.mainView.isUserInteractionEnabled = !newValue
        }
    }
    
    /// 显示HUD
    /// - Parameters:
    ///   - view: 在指定View里面显示，默认全屏
    ///   - msg: 提示字符，默认空字符串
    ///   - durationTime: 持续时间，默认全局设置，当设置为0时将需手动移除
    @objc public func showHUD(_ type: JHHUDType, inView view: UIView? = nil, msg: String? = nil, durationTime: Int = JHHUD.durationTime) {
        self.remove { finished in
            self.mainView.type = type
            self.mainView.tipsMsg = msg
            self.mainView.show(view: view)
            self.scheduledTime(durationTime)
        }
    }
    
    /// 移除HUD
    @objc public func removeHUD() {
        self.remove(completion: nil)
    }
    
    // MARK: - Private
    
    func scheduledTime(_ durationTime: Int) {
        guard durationTime != 0 else {
            return
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(durationTime), repeats: false) { _ in
            self.removeHUD()
        }
    }
    
    func remove(completion: ((Bool) -> Void)?) {
        self.timer.invalidate()
        self.mainView.remove(completion: completion)
    }
    
    /// 主视图
    var mainView: JHHUDMainView = JHHUDMainView.init()
    
    /// 计时器
    var timer: Timer = Timer()
    
    override init() {
        super.init()
        self.fontColor = JHHUD.fontColor
        self.isUserInteractionEnable = JHHUD.isUserInteractionEnable
        self.backgroundColor = JHHUD.backgroundColor
    }
}
