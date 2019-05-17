//
//  UIViewControllerExt.swift
//  Dev-goalpost
//
//  Created by Mac User on 5/16/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        //        transition.type = kCATransitionPush
        transition.type = CATransitionType.push
        //        transition.subtype = kCATransitionFromRight
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    func dismissToRoot() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        //        transition.type = kCATransitionPush
        transition.type = CATransitionType.push
        //        transition.subtype = kCATransitionFromLeft
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
