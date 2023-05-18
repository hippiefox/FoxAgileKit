//
//  FAKTableViewCell.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

open class FAKTableViewCell: UITableViewCell{
    open lazy var iconImageView = UIImageView()
    
    open lazy var titleLabel: UILabel = UILabel()
    
    open lazy var accessoryImageView: UIImageView = UIImageView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureUI(){
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(accessoryImageView)
    }
}
