//
//  JHHUDMainView.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/5.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import UIKit
import SnapKit

class JHHUDMainView: UIView {
    
    // MARK: - Public
    public func show(view: UIView?) {
        guard let rootView: UIView = view ?? JHHUDHeader.rootView else {
            return
        }
        rootView.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalTo(rootView)
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.1) {
            self.backgroundView.alpha = 1
            self.centerView.alpha = 1
            self.iconView.snp.updateConstraints { make in
                make.size.equalTo(CGSize(width: 50, height: 50))
            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        self.iconView.startAnimating()
    }
    public func remove(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.1) {
            self.backgroundView.alpha = 0
            self.centerView.alpha = 0
            self.iconView.snp.updateConstraints { make in
                make.size.equalTo(CGSize(width: 30, height: 30))
            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        } completion: { finished in
            self.tipsMsg = ""
            self.removeFromSuperview()
            completion?(finished)
        }
        self.iconView.stopAnimating()
    }
    public var fontColor: UIColor {
        get {
            return self.tipsLabel.textColor
        }
        set {
            self.tipsLabel.textColor = newValue
        }
    }
    public var backgroundViewColor: UIColor {
        get {
            return self.backgroundView.backgroundColor ?? UIColor.clear
        }
        set {
            self.backgroundView.backgroundColor = newValue
        }
    }
    public var tipsMsg: String? {
        get {
            return self.tipsLabel.text
        }
        set {
            if let newValue = newValue {
                if self.getLabWidth(labelStr: newValue) > JHHUDHeader.kScreenW/2 {
                    self.tipsMsg = String(newValue.prefix(newValue.count*2/3)) + "..."
                    return
                }
            }
            self.tipsLabel.text = newValue
            self.changeConstraints()
        }
    }
    public var type: JHHUDType {
        get {
            return self.iconView.type
        }
        set {
            self.iconView.type = newValue
        }
    }
    
    // MARK: - Private
    @objc func didClickHUD() {
        print("已禁止用户交互")
    }
    
    // MARK: - UI
    
    private func configUI() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickHUD))
        self.addGestureRecognizer(tap)
        
        self.addSubview(self.backgroundView)
        self.addSubview(self.centerView)
        self.centerView.addSubview(self.blurEffect)
        self.centerView.addSubview(self.iconView)
        self.centerView.addSubview(self.tipsLabel)
        
        self.backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        self.centerView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        self.blurEffect.snp.makeConstraints { make in
            make.edges.equalTo(self.centerView)
        }
        self.iconView.snp.makeConstraints { make in
            make.top.equalTo(self.centerView).offset(15)
            make.centerX.equalTo(self.centerView)
            make.left.equalTo(self.centerView).offset(15)
            make.right.equalTo(self.centerView).offset(-15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        self.tipsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconView.snp.bottom)
            make.centerX.equalTo(self.centerView)
            make.left.equalTo(self.centerView).offset(10).priority(.high)
            make.right.equalTo(self.centerView).offset(-10).priority(.high)
            make.bottom.equalTo(self.centerView).offset(-15)
        }
    }
    
    private func changeConstraints() {
        if (getLabWidth(labelStr: self.tipsMsg) < 40) {
            self.iconView.snp.remakeConstraints { make in
                make.top.equalTo(self.centerView).offset(15)
                make.centerX.equalTo(self.centerView)
                make.left.equalTo(self.centerView).offset(15)
                make.right.equalTo(self.centerView).offset(-15)
                make.size.equalTo(CGSize(width: 30, height: 30))
            }
            let tipsLabelOffset = (self.tipsMsg == nil || self.tipsMsg?.count == 0) ? 0 : 5
            self.tipsLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.iconView.snp.bottom).offset(tipsLabelOffset)
                make.centerX.equalTo(self.centerView)
                make.bottom.equalTo(self.centerView).offset(-15)
            }
        } else {
            self.iconView.snp.remakeConstraints { make in
                make.top.equalTo(self.centerView).offset(15)
                make.centerX.equalTo(self.centerView)
                make.size.equalTo(CGSize(width: 30, height: 30))
            }
            self.tipsLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.iconView.snp.bottom).offset(5)
                make.centerX.equalTo(self.centerView)
                make.left.equalTo(self.centerView).offset(15).priority(.high)
                make.right.equalTo(self.centerView).offset(-15).priority(.high)
                make.bottom.equalTo(self.centerView).offset(-15)
            }
        }
    }
    
    private func getLabWidth(labelStr: String?) -> CGFloat {
        guard let labelStr = labelStr else {
            return 0
        }
        let statusLabelText: String = labelStr
        let size = CGSize(width: 2000, height: 2000)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: nil, context: nil).size
        return strSize.width
    }
    
    // MARK: - Property
    private lazy var backgroundView: UIView = {
        backgroundView = UIView()
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private lazy var centerView: UIView = {
        centerView = UIView()
        centerView.layer.cornerRadius = 10
        centerView.clipsToBounds = true
        centerView.alpha = 0
        return centerView
    }()
    
    private lazy var blurEffect: UIVisualEffectView = {
        blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
        return blurEffect
    }()
    
    private lazy var iconView: JHHUDIconView = {
        iconView = JHHUDIconView()
        return iconView
    }()
    
    private lazy var tipsLabel: UILabel = {
        tipsLabel = UILabel()
        tipsLabel.textAlignment = .center
        return tipsLabel
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: CGRect())
        self.configUI()
    }
    func dealloc() {
        print("dealloc success")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
