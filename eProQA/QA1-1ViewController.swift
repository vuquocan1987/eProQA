//
//  QA1-1ViewController.swift
//  eProQA
//
//  Created by Vu Quoc An on 07/07/2019.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import UIKit

class QA1_1ViewController: UIViewController {

    @IBOutlet weak var startQuestionButton: UIButton!
    @IBOutlet weak var textForKidLabel: UILabel!
    @IBOutlet weak var explanationTextLabel: UILabel!
    @IBOutlet weak var timeandNumberofQuestionLabel: UILabel!
    var questionData: Dictionary<String, Any>?
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "QAList", ofType: "json")
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        let json = try? JSONSerialization.jsonObject(with: jsonData! as Data , options: JSONSerialization.ReadingOptions.allowFragments)
        questionData = json as? Dictionary<String, Any>
        
        if let questionData = questionData {
            navigationItem.title = (questionData[QuestionDataKeys.title] as! String)
            textForKidLabel.numberOfLines = 0
            textForKidLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            textForKidLabel.text = (questionData[QuestionDataKeys.text_for_young] as! String)
            
            textForKidLabel.sizeToFit()
            explanationTextLabel.text = (questionData[QuestionDataKeys.text] as! String)
//            startQuestionButton.setTitle(questionData[QuestionDataKeys.], for: <#T##UIControl.State#>)
            
        }

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
struct QuestionDataKeys {
    static let sub_text = "sub_text"
    static let text_for_young = "text_for_young"
    static let page = "page"
    static let all_questions = "all_questions"
    static let question_no_text = "question_no_text"
    static let text = "text"
    static let length_of_time = "length_of_time"
    static let title = "title"
    
}
