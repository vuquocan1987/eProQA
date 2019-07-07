//
//  ViewController.swift
//  eProQA
//
//  Created by Vu Quoc An on 07/07/2019.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func readFile(_ sender: Any) {
        let path = Bundle.main.path(forResource: "QAList", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
    }
    
}

