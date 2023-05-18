//
//  FAKNavigationBar.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

public class FAKNavigationBar: UIView {
    public var isContentAligmentCenterInVertical: Bool = false
    public var itemSpace: CGFloat = FoxAgileKitConfig.nav_item_space
    public var leftItem: FAKBarButtonItem? { didSet { leftItems = [leftItem] } }
    public var leftItems: [FAKBarButtonItem?] = [] { didSet { setLeftItems(leftItems) } }
    public var rightItem: FAKBarButtonItem? { didSet { rightItems = [rightItem] } }
    public var rightItems: [FAKBarButtonItem?] = [] { didSet { setRightItems(rightItems) } }
    public var itemColor: UIColor = FoxAgileKitConfig.nav_item_color {
        didSet {
            leftItems.forEach {
                if $0?.itemColor == nil {
                    $0?.itemColor = itemColor
                }
            }
            rightItems.forEach {
                if $0?.itemColor == nil {
                    $0?.itemColor = itemColor
                }
            }
        }
    }

    public var itemFont = FoxAgileKitConfig.nav_item_font {
        didSet {
            leftItems.forEach { $0?.font = itemFont }
            rightItems.forEach { $0?.font = itemFont }
        }
    }

    public var shadowColor: UIColor = FoxAgileKitConfig.nav_shadow_line_color { didSet { shadowView.backgroundColor = shadowColor } }
    public var bgAlpha: CGFloat = FoxAgileKitConfig.nav_bg_alpha { didSet { backgroundView.alpha = bgAlpha } }
    public var bgColor: UIColor = FoxAgileKitConfig.nav_bg_color { didSet { backgroundView.backgroundColor = bgColor } }
    public var leftAndRightSpace: CGFloat = FoxAgileKitConfig.nav_content_hrz_inset

    ///  优先级高于title
    public var titleView: UIView? {
        set {
            _titleView?.removeFromSuperview()
            _titleView = newValue
        }
        get {
            return _titleView
        }
    }

    // 标题
    public var titleAlignmenttCenter: Bool = true { didSet { layoutContentSubviews() } }
    public var titleColor: UIColor = FoxAgileKitConfig.nav_title_color { didSet { titleLabel?.textColor = titleColor } }
    public var titleFont = FoxAgileKitConfig.nav_title_font { didSet { titleLabel?.font = titleFont } }
    public var title: String? {
        didSet {
            if titleView != nil { return }
            if titleLabel == nil {
                titleLabel = UILabel()
                titleLabel?.textAlignment = .center
                titleLabel?.font = titleFont
                titleLabel?.textColor = titleColor
                contentView.addSubview(titleLabel!)
            }
            titleLabel?.text = title
        }
    }

    public var attriTitle: NSAttributedString? {
        didSet {
            if titleView != nil { return }
            if titleLabel == nil {
                titleLabel = UILabel()
                titleLabel?.textAlignment = .center
                titleLabel?.font = titleFont
                titleLabel?.textColor = titleColor
                contentView.addSubview(titleLabel!)
            }
            titleLabel?.attributedText = attriTitle
        }
    }

    public weak var weakController: UIViewController?

    // Private
    public lazy var backgroundView = UIImageView()
    public lazy var contentView = UIView()
    public lazy var shadowView = UIView()
    public var leftContentView: UIView?
    public var rightContentView: UIView?
    var titleLabel: UILabel?
    public var _titleView: UIView? {
        didSet {
            guard let _titleView = _titleView else { return }
            contentView.addSubview(_titleView)
            titleLabel?.removeFromSuperview()
            titleLabel = nil
        }
    }

    private let contentHeight: CGFloat = 44

    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView.backgroundColor = bgColor
        backgroundView.alpha = bgAlpha
        shadowView.backgroundColor = shadowColor
        addSubview(backgroundView)
        addSubview(contentView)
        addSubview(shadowView)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutContent()
        layoutContentSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 布局

extension FAKNavigationBar {
    private func layoutContent() {
        if bounds.size != .zero,
           backgroundView.frame.size == .zero
        {
            let contentX = leftAndRightSpace
            let contentH = contentHeight
            let contentW = bounds.width - leftAndRightSpace * 2
            var contentY: CGFloat = 0
            contentY = bounds.height - contentH

            contentView.frame = CGRect(x: contentX, y: contentY, width: contentW, height: contentH)
            shadowView.frame = CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
            backgroundView.frame = bounds
        }
    }

    private func layoutContentSubviews() {
        guard contentView.frame != .zero else { return }

        if let leftContentView = leftContentView {
            let totalWidth = leftContentView.subviews.map { $0.intrinsicContentSize.width }.reduce(0) { $0 + $1 } + itemSpace * CGFloat(leftContentView.subviews.count - 1)
            leftContentView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: contentView.bounds.height)

            for (idx, item) in leftContentView.subviews.enumerated() {
                let itemSize = item.intrinsicContentSize
                let itemY: CGFloat = (contentView.bounds.height - itemSize.height) * 0.5
                var itemX: CGFloat = 0
                if idx != 0 {
                    itemX = leftContentView.subviews[idx - 1].frame.maxX + itemSpace
                }
                item.frame = CGRect(origin: CGPoint(x: itemX, y: itemY), size: itemSize)
            }
            contentView.addSubview(leftContentView)
        }

        if let rightContentView = rightContentView {
            let totalWidth = rightContentView.subviews.map { $0.intrinsicContentSize.width }.reduce(0) { $0 + $1 } + itemSpace * CGFloat(rightContentView.subviews.count - 1)
            rightContentView.frame = CGRect(x: contentView.bounds.width - totalWidth, y: 0, width: totalWidth, height: contentView.bounds.height)

            for (idx, item) in rightContentView.subviews.reversed().enumerated() {
                let itemSize = item.intrinsicContentSize
                let itemY: CGFloat = (contentView.bounds.height - itemSize.height) * 0.5
                var itemX: CGFloat = 0
                if idx != 0 {
                    itemX = rightContentView.subviews.reversed()[idx - 1].frame.maxX + itemSpace
                }
                item.frame = CGRect(origin: CGPoint(x: itemX, y: itemY), size: itemSize)
            }
            contentView.addSubview(rightContentView)
        }

        if let titleLabel = titleLabel {
            let titleLabelH = contentView.bounds.height
            var titleLabelLeft: CGFloat = 0
            var titleLabelRight: CGFloat = 0
            if let leftContentView = leftContentView {
                titleLabelLeft = leftContentView.frame.width + itemSpace
            }
            if let rightContentView = rightContentView {
                titleLabelRight = rightContentView.frame.width + itemSpace
            }
            var titleLabelW = contentView.bounds.width - max(titleLabelLeft, titleLabelRight) * 2
            var titleLabelX = (contentView.bounds.width - titleLabelW) * 0.5
            if titleAlignmenttCenter == false {
                titleLabelW = contentView.bounds.width - titleLabelLeft - titleLabelRight
                titleLabelX = titleLabelLeft
            }
            titleLabel.frame = CGRect(x: titleLabelX, y: 0, width: titleLabelW, height: titleLabelH)
        }

        if let titleView = titleView {
            let titleViewH = contentView.bounds.height
            var titleViewLeft: CGFloat = 0
            var titleViewRight: CGFloat = 0
            if let leftContentView = leftContentView {
                titleViewLeft = leftContentView.frame.width + itemSpace
            }
            if let rightContentView = rightContentView {
                titleViewRight = rightContentView.frame.width + itemSpace
            }
            var titleViewW = contentView.bounds.width - max(titleViewLeft, titleViewRight) * 2
            var titleViewX = (contentView.bounds.width - titleViewW) * 0.5
            if titleAlignmenttCenter == false {
                titleViewW = contentView.bounds.width - titleViewLeft - titleViewRight
                titleViewX = titleViewLeft
            }
            titleView.frame = CGRect(x: titleViewX, y: 0, width: titleViewW, height: titleViewH)
            contentView.bringSubviewToFront(titleView)
        }
    }
}

// MARK: - 添加左右按钮

extension FAKNavigationBar {
    private func setLeftItems(_ items: [FAKBarButtonItem?]) {
        leftContentView?.subviews.forEach { $0.removeFromSuperview() }
        leftContentView?.removeFromSuperview()
        leftContentView = nil
        let items = items.compactMap { $0 }
        if items.count == 0 {
            layoutContentSubviews()
            return
        }
        leftContentView = UIView()
        contentView.addSubview(leftContentView!)
        items.forEach {
            if $0.itemColor == nil{
                $0.itemColor = itemColor
            }
            $0.font = itemFont
            leftContentView?.addSubview($0)
        }
        layoutContentSubviews()
    }

    private func setRightItems(_ items: [FAKBarButtonItem?]) {
        rightContentView?.subviews.forEach { $0.removeFromSuperview() }
        rightContentView?.removeFromSuperview()
        rightContentView = nil
        let items = items.compactMap { $0 }
        if items.count == 0 {
            layoutContentSubviews()
            return
        }
        rightContentView = UIView()
        contentView.addSubview(rightContentView!)
        items.forEach {
            if $0.itemColor == nil{
                $0.itemColor = itemColor
            }
            $0.font = itemFont
            rightContentView?.addSubview($0)
        }
        layoutContentSubviews()
    }
}
