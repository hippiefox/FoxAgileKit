//
//  FAKProtoAlert.swift
//  FoxAgileKit
//
//  Created by pulei yu on 2023/5/18.
//

import Foundation
import SnapKit

public extension FAKProtoAlert {
    enum Position {
        case center
        case bottom
        case right
        case left
        case top
    }
}

open class FAKProtoAlert: UIViewController {
    public let position: Position
    /// 旋转横屏时的位置
    public var rotatedPosition: Position?
    private var tapToDismiss = true
    open var fromBGColor: UIColor = .clear
    open var toBGColor: UIColor = .clear
    public var closeBlock: (()->Void)?

    public init(position: Position, tapToDismiss: Bool = true) {
        self.position = position
        self.tapToDismiss = tapToDismiss
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        transitioningDelegate = self
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    open lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    public lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSelf))
        tap.delegate = self
        return tap
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        if tapToDismiss {
            view.addGestureRecognizer(tap)
        }
        configureUI()
    }
    
    open func adjustContainerFrame(before animatePosition: Position){
        
    }
}

// MARK: - - Configure UI

extension FAKProtoAlert {
    private func configureUI() {
        view.addSubview(containerView)
        
        containerView.frame = CGRect(x: 0, y: 0, width: FAKScreenSize.minSide, height: FAKScreenSize.minSide)
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.equalTo(containerView.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(containerView.safeAreaLayoutGuide.snp.right)
            $0.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(containerView.safeAreaLayoutGuide.snp.top)
        }
    }
}

// MARK: gesture

extension FAKProtoAlert: UIGestureRecognizerDelegate {
    @objc open func tapSelf() {
        dismiss(animated: true) {
            self.closeBlock?()
        }
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let loc = gestureRecognizer.location(in: view)
        return containerView.frame.contains(loc) == false
    }
}

extension FAKProtoAlert: UIViewControllerTransitioningDelegate {
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
}

extension FAKProtoAlert: UIViewControllerAnimatedTransitioning {
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let isPresenting = view.superview == nil
        var targetPosition = position
        if FAKDeviceRotate.allowedOrientation != .portrait,
           let __p = rotatedPosition {
            targetPosition = __p
        }

        if isPresenting {
            transitionContext.containerView.addSubview(view)
            adjustContainerFrame(before: targetPosition)
            switch targetPosition {
            case .center:
                containerView.center.x = view.bounds.width / 2
                containerView.frame.origin.y = view.bounds.height
            case .bottom:
                let safeBottom = view.safeAreaInsets.bottom
                containerView.frame.size.height += safeBottom
                containerView.center.x = view.bounds.width / 2
                containerView.frame.origin.y = view.bounds.height
            case .top:
                let safeTop = view.safeAreaInsets.top
                containerView.frame.size.height += safeTop
                containerView.center.x = view.bounds.width / 2
                containerView.frame.origin.y = -containerView.frame.height
            case .right:
                let safeRight = view.safeAreaInsets.right
                containerView.frame.size.width += safeRight
                containerView.center.y = view.bounds.height / 2
                containerView.frame.origin.x = view.bounds.width
            case .left:
                let safeLeft = view.safeAreaInsets.left
                containerView.frame.size.width += safeLeft
                containerView.center.y = view.bounds.height / 2
                containerView.frame.origin.x = -containerView.bounds.width
            }
            view.backgroundColor = fromBGColor
            UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = self.toBGColor
                switch targetPosition {
                case .center:
                    self.containerView.center = .init(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
                case .bottom:
                    self.containerView.frame.origin.y = self.view.bounds.height - self.containerView.frame.height
                case .top:
                    self.containerView.frame.origin.y = 0
                case .right:
                    self.containerView.frame.origin.x = self.view.bounds.width - self.containerView.frame.width
                case .left:
                    self.containerView.frame.origin.x = 0
                }
            } completion: { _ in
                transitionContext.completeTransition(true)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                switch targetPosition {
                case .center, .bottom:
                    self.containerView.frame.origin.y = self.view.frame.height
                case .top:
                    self.containerView.frame.origin.y = -self.containerView.frame.height
                case .right:
                    self.containerView.frame.origin.x = self.view.frame.width
                case .left:
                    self.containerView.frame.origin.x = -self.containerView.frame.width
                }
            } completion: { _ in
                self.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }
}
