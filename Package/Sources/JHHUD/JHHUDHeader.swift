//
//  JHHUDHeader.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/5.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import UIKit

class JHHUDHeader {
    
    static var kScreenW: CGFloat {
        get {
            return self.rootView?.bounds.width ?? 400
        }
    }
    
    static var rootView: UIView? {
        guard let rootWindow: UIWindow = UIApplication.shared.delegate?.window as? UIWindow,
              let rootView = rootWindow.rootViewController?.view as? UIView
        else {
            return nil
        }
        return rootView
    }
}
