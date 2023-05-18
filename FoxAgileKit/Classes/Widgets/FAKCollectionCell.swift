//
//  FAKCollectionCell.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

open class FAKCollectionCell: UICollectionViewCell {
    public lazy var iconImageView = UIImageView()

    public lazy var titleLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func configUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
}
