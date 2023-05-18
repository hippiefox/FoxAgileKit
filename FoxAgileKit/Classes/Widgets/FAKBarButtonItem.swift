//
//  FAKBarButtonItem.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
open class FAKBarButtonItem: UIControl {
    open var font: UIFont = .systemFont(ofSize: 17) {
        didSet {
            titleLabel?.font = font
        }
    }

    open var itemColor: UIColor? {
        didSet {
            guard let itemColor = itemColor else { return }
            titleLabel?.textColor = itemColor
            imageView?.tintColor = itemColor
        }
    }

    private var titleLabel: UILabel?
    private var imageView: UIImageView?
    private var customView: UIView?

    public init(title: String, target: Any?, selector: Selector) {
        super.init(frame: .zero)
        addTarget(target, action: selector, for: .touchUpInside)
        titleLabel = UILabel()
        titleLabel?.text = title
        titleLabel?.font = font
        titleLabel?.textColor = tintColor
        addSubview(titleLabel!)
    }

    public init(image: UIImage?, target: Any?, selector: Selector) {
        super.init(frame: .zero)
        addTarget(target, action: selector, for: .touchUpInside)
        imageView = UIImageView()
        imageView?.image = image
        addSubview(imageView!)
    }

    public init(customView: UIView) {
        super.init(frame: .zero)
        self.customView = customView
        addSubview(customView)
    }

    override open var intrinsicContentSize: CGSize {
        if let titleLabel = titleLabel {
            titleLabel.sizeToFit()
            return titleLabel.bounds.size
        } else if let imageView = imageView {
            imageView.sizeToFit()
            return imageView.bounds.size
        } else if let customView = customView {
            return customView.bounds.size
        } else {
            return .zero
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
