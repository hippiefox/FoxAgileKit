//
//  TableViewExt.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import UIKit

public extension UITableView {
    func fak_sectionRoundRect(at indexPath: IndexPath,
                              for cell: UITableViewCell,
                              backgroundColor: UIColor = .white,
                              radius: CGFloat = 8) {
        let layer = CAShapeLayer()
        let rowNum = numberOfRows(inSection: indexPath.section)
        let cellBounds = cell.bounds
        var roundingCorner = UIRectCorner(rawValue: 0)
        var roundRadius = radius

        switch indexPath.row {
        case let r where r == 0 && r == rowNum - 1:
            roundingCorner = .allCorners
        case let r where r == 0:
            roundingCorner = UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue)
        case let r where r == rowNum - 1:
            roundingCorner = UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue)
        default:
            roundRadius = 0
        }

        let path = UIBezierPath(roundedRect: cellBounds, byRoundingCorners: roundingCorner, cornerRadii: .init(width: roundRadius, height: roundRadius))
        layer.path = path.cgPath
        layer.fillColor = backgroundColor.cgColor
        let cellBgView = UIView()
        cellBgView.layer.insertSublayer(layer, at: 0)
        cell.backgroundView = cellBgView
    }
}
