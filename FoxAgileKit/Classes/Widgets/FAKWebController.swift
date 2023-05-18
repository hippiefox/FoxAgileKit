//
//  FAKWebController.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import WebKit

public extension FAKWebController {
    enum SomeKeyPath: String, CaseIterable {
        case estimatedProgress
        case canGoBack
        case title
    }
}

open class FAKWebController: UIViewController {
    /// a solid title for web controller, ignore webview content title
    open var solidTitle: String?
    open var msgs: [String] = []
    public let urlString: String
    open var hasShown: Bool = false
    /// toggle pan gesture back
    public var isForbidGestureBack = false

    public init(urlString: String, msgs: [String] = []) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
        self.msgs = msgs
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 进度条的进度色
    open var progressTintColor: UIColor = .blue {
        didSet {
            progressView.tintColor = progressTintColor
        }
    }

    /// 进度条的背景色
    open var progressTrackColor: UIColor = .white {
        didSet {
            progressView.trackTintColor = progressTrackColor
        }
    }

    open lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.tintColor = progressTintColor
        view.trackTintColor = progressTrackColor
        return view
    }()

    open lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        if msgs.isEmpty == false {
            let preference = WKPreferences()
            preference.javaScriptCanOpenWindowsAutomatically = true
            preference.javaScriptEnabled = true
            config.preferences = preference
            msgs.forEach {
                config.userContentController.add(self, name: $0)
            }
        }
        let view = WKWebView(frame: .zero, configuration: config)
        view.backgroundColor = .white
        view.scrollView.showsVerticalScrollIndicator = false
        view.scrollView.showsHorizontalScrollIndicator = false
        return view
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        hasShown = true
        configUI()
        loadUrl()
    }

    open func loadUrl() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        webView.load(request)
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        // estimatedProgress
        if keyPath == SomeKeyPath.estimatedProgress.rawValue {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: UIView.AnimationOptions.curveLinear, animations: {
                    self.progressView.alpha = 0
                }) { _ in
                    self.progressView.setProgress(0.0, animated: false)
                }
            }
        }
        // canGoBack
        if keyPath == SomeKeyPath.canGoBack.rawValue {
            if isForbidGestureBack { return }

            if let newValue = change?[NSKeyValueChangeKey.newKey] as? Bool {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = !newValue
            } else {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
        // title
        if keyPath == SomeKeyPath.title.rawValue {
            title = webView.title
        }
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isForbidGestureBack {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isForbidGestureBack {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

//    override open func actionBack() {
//        msgs.forEach {
//            webView.configuration.userContentController.removeScriptMessageHandler(forName: $0)
//        }
//
//        super.actionBack()
//    }

    deinit {
        if hasShown {
            msgs.forEach {
                webView.configuration.userContentController.removeScriptMessageHandler(forName: $0)
            }
            SomeKeyPath.allCases.forEach {
                webView.removeObserver(self, forKeyPath: $0.rawValue)
            }
        }
    }
}

// MARK: - WKScriptMessageHandler

extension FAKWebController: WKScriptMessageHandler {
    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
}

// MARK: - UI

extension FAKWebController {
    private func configUI() {
        title = solidTitle
        view.backgroundColor = .white
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(progressView.snp.bottom)
        }
        SomeKeyPath.allCases.forEach {
            webView.addObserver(self, forKeyPath: $0.rawValue, options: .new, context: nil)
        }
    }
}
