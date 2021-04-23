//
//  ViewController.swift
//  pan
//
//  Created by lina on 2021/4/23.
//

import UIKit
import HWPanModal

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.presentPanModal(PanViewController())
        
    }
}

