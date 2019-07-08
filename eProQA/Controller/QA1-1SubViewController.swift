//
//  QA1-1SubViewController.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/8/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit
import FPStepView
import SwiftyJSON
class QA1_1SubViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var questionsList = [Question]()
    var pageNumber: Int = 0 {
        didSet {
            title = "\(pageNumber)"
        }
    }
    lazy var numberOfChoice:Int = {
        return questionPageData[QuestionDataKeys.choice][QuestionDataKeys.choices].count
    }()
    
    var questionPageData:JSON! {
        didSet {
            pageNumber = questionPageData[QuestionDataKeys.page].intValue
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // remember to fix this
        if section == (tableView.numberOfSections - 1) {
            return 1
        } else {
            return numberOfChoice
        }
        
    }
    func setUpPageData(pageJsonData: JSON) {
        let jsonQuestion = pageJsonData[QuestionDataKeys.question]
        let choice = 
        var question = Question(number: jsonQuestion[QuestionDataKeys.question_no],
                                text: jsonQuestion[QuestionDataKeys.text],
                                subtext: jsonQuestion[QuestionDataKeys.sub_text],
                                choice: jsonQuestion,
                                input: <#T##String?#>,
                                sub_questions: <#T##[Question]?#>)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // +1 for the next question button
        return 1 + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == tableView.numberOfSections {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionChoice", for: indexPath)
            cell.textLabel?.text = questionPageData[QuestionDataKeys.choice][QuestionDataKeys.choices][indexPath.item].stringValue
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nextButton", for: indexPath)
            if let nextButtonCell = cell as? NextButtonUITableViewCell {
                nextButtonCell.nextQuestionButton.setTitle("Next Question", for: UIControl.State.normal)
                
            }
            return cell
        }
    }
    

    @IBOutlet weak var questionTableView: UITableView! {
        didSet {
            questionTableView.delegate = self
            questionTableView.dataSource = self
        }
    }
    @IBOutlet weak var stepView: FPStepView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stepView.totalStep = 10
        stepView.currentStep = 3

        // Do any additional setup after loading the view.
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

