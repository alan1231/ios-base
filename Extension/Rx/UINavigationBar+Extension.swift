//
//  UINavigationBar+Extension.swift
//  ios-swift
//
//  Created by Eddie Chen on 2023/2/8.
//

import UIKit
extension UINavigationBar {
    func setBackButtonTitle(_ title:String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.topItem?.backBarButtonItem = backButton
    }
    func setBackButtonImage(_ image: UIImage?){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.image = image
        self.topItem?.backBarButtonItem = backButton
    }
}

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
