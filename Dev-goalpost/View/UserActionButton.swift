//
//  UserActionButton.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/20/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit
class UserActionButton : UIButton {
    init (title: String, action: Selector, owner: UIViewController, backColor: UIColor, btnTextColor: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: owner.view.frame.size.width, height: 50))
        self.backgroundColor = backColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(btnTextColor, for: .normal)
        self.addTarget(owner, action: action, for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
