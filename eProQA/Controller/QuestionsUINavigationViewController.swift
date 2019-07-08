//
//  QuestionsUINavigationViewController.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/8/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit
import SwiftyJSON
class QuestionsUINavigationViewController: UINavigationController {
    var questionsData:JSON? {
        didSet {
            questionAndAnswerData = questionsData
        }
    }
    var questionAndAnswerData:JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if let questionViewController = viewController as? QA1_1SubViewController {
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
