//
//  FAKProtoController.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
open class FAKProtoController: UIViewController {
    open var fak_navigationBar: FAKNavigationBar?

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        configNavigationBar()
    }

//    open func customLeftNavigationItem(_ target: Any?, selector: Selector) -> FAKBarButtonItem? {
//        var leftItem: FAKBarButtonItem?
//        if navigationController != nil {
//            leftItem = FAKBarButtonItem(customView: naviBackButton)
//        }
//        return leftItem
//    }

    @objc open func actionBack() {
        navigationController?.popViewController(animated: true)
    }

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let fak_navigationBar = fak_navigationBar {
            fak_navigationBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: FAKScreenSize.navHeight)
            view.bringSubviewToFront(fak_navigationBar)
        }
    }

    open func configNavigationBar() {
        if let navigationController = navigationController {
            fak_navigationBar = FAKNavigationBar()
            fak_navigationBar?.weakController = self
            view.addSubview(fak_navigationBar!)
            if navigationController.viewControllers.count > 1 {
//                mt_navigationBar?.leftItem = customLeftNavigationItem(self, selector: #selector(actionBack))
            }
        }
    }

    deinit {
        FAKLog("------>deinit", self.classForCoder.description())
    }
}
