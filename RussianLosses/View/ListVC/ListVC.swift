//
//  ListVC.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import UIKit

class ListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Russian losses"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
