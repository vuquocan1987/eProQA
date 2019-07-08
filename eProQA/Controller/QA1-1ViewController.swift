//
//  QA1-1ViewController.swift
//  eProQA
//
//  Created by Vu Quoc An on 07/07/2019.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit
import SwiftyJSON
class QA1_1ViewController: UIViewController {

    @IBOutlet weak var startQuestionButton: UIButton!
    @IBOutlet weak var textForKidLabel: UILabel!
    @IBOutlet weak var explanationTextLabel: UILabel!
    @IBOutlet weak var timeandNumberofQuestionLabel: UILabel!
    
 
    var tableQuestionData:JSON!
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "QAList", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        let json = try? JSONSerialization.jsonObject(with: jsonData! as Data , options: JSONSerialization.ReadingOptions.allowFragments)
        let jsonDataS = (jsonData as! Data)
        tableQuestionData = try! JSON(data: jsonDataS)

            navigationItem.title = tableQuestionData[QuestionDataKeys.title].stringValue
            textForKidLabel.text = tableQuestionData[QuestionDataKeys.text_for_young].stringValue
            explanationTextLabel.text = tableQuestionData[QuestionDataKeys.text].stringValue
//            startQuestionButton.setTitle(questionData[QuestionDataKeys.], for: <#T##UIControl.State#>)
            let timeAndNumberOfQuestionText = "\(tableQuestionData[QuestionDataKeys.length_of_time].stringValue) \n \(tableQuestionData[QuestionDataKeys.all_questions].stringValue)"
            timeandNumberofQuestionLabel.text = timeAndNumberOfQuestionText
        // Do any additional setup after loading the view.
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuestion" {
            let questionsNavigationController = segue.destination as! QuestionsUINavigationViewController
            questionsNavigationController.questionsData = tableQuestionData[QuestionDataKeys.page]
            if let questionViewController = questionsNavigationController.viewControllers[0] as? QA1_1SubViewController {
                questionViewController.setUpPageData[tableQuestionData[QuestionDataKeys.page][0]]
            }
        }
    }
}
struct QuestionDataKeys {
    static let sub_text = "sub_text"
    static let text_for_young = "text_for_young"
    static let page = "page"
    static let all_questions = "all_questions"
    static let question_no_text = "question_no_text"
    static let text = "text"
    static let length_of_time = "length_of_time"
    static let title = "title"
    static let answer = "answer"
    static let choice = "choice"
    static let choices = "choices"
    static let question = "question"
    static let question_no = "question_no"
    static let item_no = "item_no"
    static let item_text = "item_text"
    static let start_text = "start_text"
    static let end_text = "end_text"
    static let input = "input"
    static let sub_questions = "sub_questions"
}
