//
//  BottomSheetController.swift
//  MapBottomSheet
//
//  Created by Dariel on 2018/8/25.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint)
}

protocol BottomSheet: AnyObject {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

typealias BottomSheetViewController = UIViewController & BottomSheet

class BottomSheetContainerView: UIView {
    
    private let mainView: UIView
    private let sheetView: UIView
    private let sheetBackground = BottomSheetBackgroundView()
    private var sheetBackgroundTopConstraint: NSLayoutConstraint? = nil
    
    init(mainView: UIView, sheetView: UIView) {
        self.mainView = mainView
        self.sheetView = sheetView
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    var topDistance: CGFloat = 0 {
        didSet {
            sheetBackgroundTopConstraint?.constant = topDistance
        }
    }
    
    private func setupViews() {
        
        // 主视图填充整个view
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: leftAnchor),
            mainView.rightAnchor.constraint(equalTo: rightAnchor),
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        // 底部的背景视图
        addSubview(sheetBackground)
        sheetBackground.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = sheetBackground.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            topConstraint,
            sheetBackground.heightAnchor.constraint(equalTo: heightAnchor),
            sheetBackground.leftAnchor.constraint(equalTo: leftAnchor),
            sheetBackground.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        sheetBackgroundTopConstraint = topConstraint
        
        // 底部视图
        addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leftAnchor.constraint(equalTo: leftAnchor),
            sheetView.rightAnchor.constraint(equalTo: rightAnchor),
            sheetView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    // MARK: - UIView overrides
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        // sheetBackground的响应链传递到sheetView上
        if sheetBackground.bounds.contains(sheetBackground.convert(point, from: self)) {
            return sheetView.hitTest(sheetView.convert(point, from: self), with: event)
        }
        return mainView.hitTest(mainView.convert(point, from: self), with: event)
    }
    
}

class BottomSheetContainerViewController: UIViewController {
    
    private let mainViewController: UIViewController
    private let sheetViewController: BottomSheetViewController
    
    
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)
    
    init(mainViewController: UIViewController, sheetViewController: BottomSheetViewController) {
        self.mainViewController = mainViewController
        self.sheetViewController = sheetViewController
        
        super.init(nibName: nil, bundle: nil)
        
        addChildViewController(mainViewController)
        addChildViewController(sheetViewController)
        
        sheetViewController.bottomSheetDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = bottomSheetContainerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewController.didMove(toParentViewController: self)
        sheetViewController.didMove(toParentViewController: self)
    }
    
}

extension BottomSheetContainerViewController: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
    }
}
