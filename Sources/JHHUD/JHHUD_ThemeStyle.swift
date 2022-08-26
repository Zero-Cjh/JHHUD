//
//  JHHUD_ThemeStyle.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/25.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import Foundation
import UIKit

@objc public extension JHHUD {
    
    /// 持续时间
    ///
    /// Default: 40s
    /// 如果设置为0，则持续存在，需手动释放
    static var durationTime: Int {
        get {
            return JHHUD_DurationTime
        }
        set {
            JHHUD_DurationTime = newValue
        }
    }
    
    /// 字体颜色
    ///
    /// Default: darkText
    static var fontColor: UIColor {
        get {
            return JHHUD_FontColor
        }
        set {
            JHHUD_FontColor = newValue
            JHHUDManager.fontColor = newValue
        }
    }
    
    /// 背景色
    ///
    /// Default: clear
    static var backgroundColor: UIColor {
        get {
            return JHHUD_BackgroundColor
        }
        set {
            JHHUD_BackgroundColor = newValue
            JHHUDManager.backgroundColor = newValue
        }
    }
    
    /// 用户是否可以交互
    ///
    /// Default: false 全屏不可交互
    /// 如设置InView显示HUD，则指定窗口不可互动
    static var isUserInteractionEnable: Bool {
        get {
            return JHHUD_IsUserInteractionEnable
        }
        set {
            JHHUD_IsUserInteractionEnable = newValue
            JHHUDManager.isUserInteractionEnable = newValue
        }
    }
}

private var JHHUD_DurationTime: Int = 40
private var JHHUD_FontColor: UIColor = .darkGray
private var JHHUD_BackgroundColor: UIColor = .clear
private var JHHUD_IsUserInteractionEnable: Bool = false
