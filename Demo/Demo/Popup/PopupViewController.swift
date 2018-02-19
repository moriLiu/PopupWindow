//
//  PopupViewController.swift
//  WindowPopup
//
//  Created by Shinji Hayashi on 2017/12/21.
//  Copyright © 2017年 shinji hayashi. All rights reserved.
//

import UIKit
import PopupWindow

class PopupViewController: BasePopupViewController {

    enum Const {
        static let popupDuration: TimeInterval = 0.3
        static let transformDuration: TimeInterval = 0.4
    }

    var isTop: Bool = true
    private var popupItem: PopupItem?

    private let topPopupItem = PopupItem(view: DemoPopupView.view(),
                                         height: DemoPopupView.Const.height,
                                         type:.rounded(cornerSize: 8),
                                         direction: .top,
                                         margin: 8,
                                         hasBlur: true,
                                         duration: Const.popupDuration)

    private let bottomPopupItem = PopupItem(view: DemoPopupView.view(),
                                            height: DemoPopupView.Const.height,
                                            type:.rounded(cornerSize: 8),
                                            direction: .bottom,
                                            margin: 8,
                                            hasBlur: true,
                                            duration: Const.popupDuration)

    override func viewDidLoad() {
        super.viewDidLoad()
        if isTop {
            popupItem = topPopupItem
            configurePopupItem(popupItem!)
        } else {
            popupItem = bottomPopupItem
            configurePopupItem(popupItem!)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let popupItem = popupItem, let view = popupItem.view as? DemoPopupView {
            view.configureDemoPopupView(popupItem: popupItem)
            
            view.closeButtonTapHandler = { [weak self] in
                guard let me = self, let popupItem = me.popupItem else { return }
                me.dismissPopupView(duration: Const.popupDuration, curve: .easeInOut, direction: popupItem.direction) { _ in
                    PopupWindowManager.shared.changeKeyWindow(rootViewController: nil)
                }
            }
        }

        DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 3.0 ) { [weak self] in
            guard let me = self, let popupItem = me.popupItem else { return }
            me.dismissPopupView(duration: Const.popupDuration, curve: .easeInOut, direction: popupItem.direction) { _ in }
        }
    }
}


