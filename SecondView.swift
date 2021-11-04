//
//  SecondView.swift
//  QuickAndNimble
//
//  Created by New Account on 11/4/21.
//

import Foundation

import UIKit



@objc class SecondView : UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var userLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    
     @objc public var userId: String?
     @objc public var titleItem : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        userLabel.text = userId
        titleLabel.text = titleItem
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
    }
    
}


