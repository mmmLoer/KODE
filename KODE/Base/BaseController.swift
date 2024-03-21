//
//  BaseController.swift
//  KODE
//
//  Created by Матвей Горохов on 18.03.2024.
//

import UIKit

class BaseController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
}

@objc extension BaseController {
    func addViews(){}
    func layoutViews(){}
    func configure(){
        view.backgroundColor = .white
    }
}
