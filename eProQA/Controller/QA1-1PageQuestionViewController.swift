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
class QA1_1PageQuestionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var questionsList : [Question]! {
        didSet {
            tableView.reloadData()
        }
    }
    var pageList: [QuestionPage]!
    var currentPageIndex = 0 {
        didSet {
            reloadPage()
        }
    }
    var currentPage: QuestionPage! {
        didSet {
            currentPageNumber = currentPage.pageNumber
//            questionsList.append(currentPage.question!)
        }
    }
    var currentPageNumber: Int = 0 {
        didSet {
            title = "\(currentPageNumber)"
        }
    }
    func reloadPage(){
        currentPage = pageList[currentPageIndex]
        questionsList = currentPage.getQuestionList()
        title = "\(currentPageNumber)/\(pageList.count)"
        stepView.totalStep = pageList.count
        stepView.currentStep = currentPage.pageNumber
        stepView.setNeedsDisplay()
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        currentPageIndex -= 1
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Warning", message: "Go back to home without saving answers?", preferredStyle: .alert)
        let noAction = UIAlertAction(
            title: "No", style: .default, handler: nil)
        //you can add custom actions as well
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: getToHome  )
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func getToHome (sender : UIAlertAction) {
        // how?? :)))
     
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // in case it's the last section, there is one line for next question
        if section == (tableView.numberOfSections - 1 ) {
            return 1
        } else {
            switch questionsList[section].questionType {
            case QuestionType.bigText:
                return 1
            case QuestionType.input1TxtField:
                return 1
            case QuestionType.input2TxtField:
                return 1
            default:
                return questionsList[section].choice!.choiceList.count
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == (tableView.numberOfSections-1) {
            return
        }
        let question = questionsList[indexPath.section]
        question.choice?.selectChoice(index: indexPath.item)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // set question title here
        if section == (tableView.numberOfSections - 1) {
            return nil
        }
        
        return questionsList[section].text
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // +1 for the next question button
        return questionsList.count + 1
    }
    func getCellForBigText(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BigText", for: indexPath)
        return cell
    }
    func getCellForOneTextField(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneTextField", for: indexPath)
        return cell
    }
    var currentTag = 0
    func generateNewTag ()-> Int{
        currentTag += 1
        return currentTag
    }
    var tagToQuestion = [Int:Question]()
    func getCellForTwoTextFields(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoTextFields", for: indexPath)
        
        
        let twoInputCell = cell as! TwoTextFieldsTableViewCell
        let firstTextField = twoInputCell.firstTextField!
        let secondTextField = twoInputCell.secondTextField!
        let firstLabel = twoInputCell.firstLabel!
        let centerLabel = twoInputCell.centerLabel!
        let lastLabel = twoInputCell.lastLabel!
        if let firstText = question.input?.first {
            firstLabel.text = firstText
            firstLabel.isHidden = false
        } else {
            firstLabel.isHidden = true
        }
        if let centerText = question.input?.center {
            centerLabel.text = centerText
            firstLabel.isHidden = false
        } else {
            firstLabel.isHidden = true
        }
        if let lastText = question.input?.last {
            lastLabel.text = lastText
            lastLabel.isHidden = false
        } else {
            lastLabel.isHidden = true
        }
        tagToQuestion.removeValue(forKey: firstTextField.tag)
        let newTag = generateNewTag()
        // remove the old tag before setting new tag
        tagToQuestion.removeValue(forKey: firstTextField.tag)
        twoInputCell.firstTextField.tag = newTag
        tagToQuestion[newTag] = question
        firstTextField.delegate = self
        firstTextField.text = question.input?.firstBoxInput
        
        if question.questionType == QuestionType.input1TxtField {
            secondTextField.isHidden = true
            lastLabel.isHidden = true
        } else {
            secondTextField.isHidden = false
            lastLabel.isHidden = false
            tagToQuestion.removeValue(forKey: secondTextField.tag)
            let newTag = generateNewTag()
            secondTextField.tag = newTag
            tagToQuestion[newTag] = question
            secondTextField.delegate = self
            secondTextField.text = question.input?.secondBoxInput

        }
        
        return cell
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let question = tagToQuestion[textField.tag]
        question!.input?.firstBoxInput = textField.text
        question!.input?.secondBoxInput = textField.text
    }

    func getCellForDefault(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionChoice", for: indexPath)
        if let answerCell = cell as? AnswerTableViewCell {
            let choiceItem = question.choice!.choiceList[indexPath.item]
            answerCell.textChoiceLabel.text = choiceItem.itemText
            if (choiceItem.isSelected) {
                answerCell.checkLabel.text = "c"
            } else {
                answerCell.checkLabel.text = " "
            }
        }
        
        return cell

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // the last section is the next question button
        if indexPath.section == tableView.numberOfSections - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nextButton", for: indexPath)
            if let nextButtonCell = cell as? NextButtonUITableViewCell {
                nextButtonCell.nextQuestionButton.setTitle("Next Question", for: UIControl.State.normal)
                nextButtonCell.nextQuestionButton.addTarget(self, action: #selector(nextQuestionTouched), for: .touchUpInside)
            }
            return cell
        }
        // case if it's still in the questions sections
        let question = questionsList[indexPath.section]
        switch question.questionType {
        case .bigText:
            return getCellForBigText(tableView, cellForRowAt: indexPath, question: question)
        case .input1TxtField :
            //use same function as 2 textField case
            return getCellForTwoTextFields(tableView, cellForRowAt: indexPath, question: question)
            
        case .input2TxtField :
            return getCellForTwoTextFields(tableView, cellForRowAt: indexPath, question: question)
            
        default:
            return getCellForDefault(tableView, cellForRowAt: indexPath, question: question)
        }
    }
    @objc func nextQuestionTouched(sender: UIButton) {
        if currentPageIndex < pageList.count - 1 {
            // once you change current
            currentPageIndex += 1
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        reloadPage()
        
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

