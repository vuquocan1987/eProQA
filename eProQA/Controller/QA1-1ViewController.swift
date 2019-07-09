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
    
 
    var questionaire: Questionaire!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "QAList", ofType: "json")
        let quesitonaireData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        let questionaireJSON = try! JSON(data: quesitonaireData! as Data)
        questionaire = Questionaire(data: questionaireJSON)
        navigationItem.title = questionaire.title
        textForKidLabel.text = questionaire.textForKid
        explanationTextLabel.text = questionaire.explainText
//            startQuestionButton.setTitle(questionData[QuestionDataKeys.], for: <#T##UIControl.State#>)
        
        timeandNumberofQuestionLabel.text = " \(questionaire.timeLength)\n\(questionaire.questionCount) "
        // Do any additional setup after loading the view.
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuestion" {
            let questionsNavigationController = segue.destination as! QuestionsUINavigationViewController
            questionsNavigationController.pageList = questionaire.questionPages
            if let questionViewController = questionsNavigationController.viewControllers[0] as? QA1_1SubViewController {
                questionViewController.page = questionaire.questionPages[0]
            }
        }
    }
}

