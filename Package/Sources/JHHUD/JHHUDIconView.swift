//
//  JHHUDIconView.swift
//  JHHUD
//
//  Created by Junhong on 2022/8/12.
//  Copyright © 2022 JHHUD. All rights reserved.
//

import UIKit
import SnapKit

class JHHUDIconView: UIView {
    
    // MARK: - Public
    func startAnimating() {
        if (self.type == .Loading) {
            self.flowerLoadingView.startAnimating()
        }
    }
    
    func stopAnimating() {
        self.flowerLoadingView.stopAnimating()
    }
    
    public var type: JHHUDType {
        get {
            return iconType
        }
        set {
            self.iconType = newValue
            self.configUI(newValue)
        }
    }
    
    // MARK: - Private
    private func configUI(_ type: JHHUDType) {
        self.successIcon.removeFromSuperview()
        self.failIcon.removeFromSuperview()
        self.flowerLoadingView.removeFromSuperview()
        var view: UIView?
        switch type {
        case .Loading:
            view = self.flowerLoadingView
        case .Success:
            view = self.successIcon
        case .Fail:
            view = self.failIcon
        }
        guard let view = view else {
            return
        }
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private lazy var successIcon: UIImageView = {
        successIcon = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        successIcon.tintColor = UIColor.gray
        successIcon.contentMode = .scaleAspectFit
        return successIcon
    }()
    
    private lazy var failIcon: UIImageView = {
        failIcon = UIImageView(image: UIImage(systemName: "xmark.circle"))
        failIcon.tintColor = UIColor.gray
        failIcon.contentMode = .scaleAspectFit
        return failIcon
    }()
    
    private lazy var flowerLoadingView: UIActivityIndicatorView = {
        flowerLoadingView = UIActivityIndicatorView(style: .large)
        flowerLoadingView.color = UIColor.darkGray
        return flowerLoadingView
    }()
    
    private var iconType: JHHUDType = .Loading
    
    // MARK: - Init
    init() {
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
