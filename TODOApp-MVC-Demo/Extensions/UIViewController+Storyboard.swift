//
//  UIViewController+Storyboard.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK:- make instant from the storyBoard
    class func create<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
               //MARK:- set up backGround image for the views
    func setUpTheBackGroundImage(imageName: String)  {
         let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
         backgroundImage.image = UIImage(named: "\(imageName)")
         backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
         self.view.insertSubview(backgroundImage, at: 0)
     }
}
