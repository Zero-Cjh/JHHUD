//
//  JHHUD.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/5.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import UIKit

public enum JHHUDType {
    /// Loading动画
    case Loading
    /// 成功
    case Success
    /// 失败
    case Fail
}

/// HUD快捷单例
public let JHHUDManager = JHHUD.Manager

public class JHHUD: NSObject {
    
    /// 单例
    public static let `Manager` = JHHUD.init()
    
    // MARK: - Property
    
    /// 持续时间
    ///
    /// Default: 40s
    /// 如果设置为0，则持续存在，需手动释放
    public var durationTime: Int = 40
    
    /// 字体颜色
    ///
    /// Default: darkText
    public var fontColor: UIColor {
        get {
            return self.mainView.fontColor
        }
        set {
            self.mainView.fontColor = newValue
        }
    }
    
    /// 背景色
    ///
    /// Default: clear
    public var backgroundColor: UIColor {
        get {
            return self.mainView.backgroundViewColor
        }
        set {
            return self.mainView.backgroundViewColor = newValue
        }
    }
    
    /// 用户是否可以交互
    ///
    /// Default: false 全屏不可交互
    /// 如设置InView显示HUD，则指定窗口不可互动
    public var isUserInteractionEnable: Bool {
        get {
            return self.mainView.isUserInteractionEnabled
        }
        set {
            self.mainView.isUserInteractionEnabled = !newValue
        }
    }
    
    /// 主视图
    var mainView: JHHUDMainView = JHHUDMainView.init()
    
    /// 计时器
    var timer: Timer = Timer()
    
    override init() {
        super.init()
        self.fontColor = UIColor.darkText
        self.isUserInteractionEnable = false
        self.backgroundColor = UIColor.clear
    }
}
