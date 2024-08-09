//
//  WebFFlutterViewController.swift
//  Runner
//
//  Created by 黄鸿昌 on 2024/8/9.
//

import UIKit

class WebFFlutterViewController: FlutterViewController {
    var deinitHandler: ((Int) -> Void)?
    var flutterEngineId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        deinitHandler?(flutterEngineId ?? 0)
        
        deinitHandler = nil
    }

}
