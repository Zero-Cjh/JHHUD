//
//  JHHUDMethod.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/5.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import Foundation
import UIKit

extension JHHUD {
    
    // MARK: - Public
    
    /// 显示HUD
    /// - Parameters:
    ///   - view: 在指定View里面显示，默认全屏
    ///   - msg: 提示字符，默认空字符串
    ///   - durationTime: 持续时间，默认全局设置，当设置为0时将需手动移除
    open func showHUD(_ type: JHHUDType, inView view: UIView? = nil, msg: String? = nil, durationTime: Int? = nil) {
        self.remove { finished in
            self.mainView.type = type
            self.mainView.tipsMsg = msg
            self.mainView.show(view: view)
            self.scheduledTime(durationTime)
        }
    }
    
    /// 移除HUD
    open func removeHUD() {
        self.remove(completion: nil)
    }
    
    // MARK: - Private
    
    private func scheduledTime(_ durationTime: Int?) {
        if let durationTime = durationTime,
           durationTime == 0 {
            return
        }
        if (self.durationTime == 0) {
            return
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(durationTime ?? self.durationTime), repeats: false) { _ in
            self.removeHUD()
        }
    }
    
    private func remove(completion: ((Bool) -> Void)?) {
        self.timer.invalidate()
        self.mainView.remove(completion: completion)
    }
}
