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
class QA1_1PageQuestionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    var questionsList : [Question]! {
        didSet {
            tableView.reloadData()
        }
    }
    var pageList: [QuestionPage]!
    var currentPageIndex = 0 {
        didSet {
            reloadPage()
            // very important !!! I must commit all answer before back/next enable!!!
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
        if currentPageIndex == 0 {
            backButton.isEnabled = false
        } else {
            backButton.isEnabled = true
        }
        questionsList = currentPage.getQuestionList()
        title = "\(currentPageNumber)/\(pageList.count)"
        stepView.totalStep = pageList.count
        stepView.currentStep = currentPage.pageNumber
        stepView.setNeedsDisplay()
        currentTag = 0
        
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
        if section >= (questionsList.count ) {
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
        if indexPath.section >= (questionsList.count) {
            return
        }
        
        let question = questionsList[indexPath.section]
        question.choice?.selectChoice(index: indexPath.item)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // set question title here
        if section >= (questionsList.count) {
            return nil
        }
        
        return questionsList[section].text
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // +1 for the next question button
        if currentPageIndex == questionsList.count {
            return questionsList.count + 2
        }
        return questionsList.count + 1
    }
    func getBigTextCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BigText", for: indexPath)
        let bigTextCell = cell as! BigTextTableViewCell
        let textView = bigTextCell.textView!

        // delete the old tag to question pair and assign new tag - question pair

        textView.text = question.bigTextBoxText
        textView.tag = indexToTag(indexPath: indexPath)
        textView.delegate = self

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
    func tagToIndexPath(tag: Int) -> IndexPath {
            return IndexPath(item: tag%questionsList.count, section: tag/questionsList.count)
    }
    func indexToTag(indexPath: IndexPath) -> Int {
        return indexPath.item + indexPath.section*questionsList.count
        
    }
//    var tagToQuestion = [Int:Question]()
    func getTwoTextFieldCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell{
        
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
        
        // remove the old tag before setting new tag
        twoInputCell.firstTextField.tag = indexToTag(indexPath: indexPath)
        
        firstTextField.delegate = self
        firstTextField.text = question.input?.firstBoxInput
        
        if question.questionType == QuestionType.input1TxtField {
            secondTextField.isHidden = true
            lastLabel.isHidden = true
        } else {
            secondTextField.isHidden = false
            lastLabel.isHidden = false


            secondTextField.tag = indexToTag(indexPath: indexPath)
            
            secondTextField.delegate = self
            secondTextField.text = question.input?.secondBoxInput
        }
        return cell
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let indexPath = tagToIndexPath(tag: textField.tag)
        let question = questionsList[indexPath.section]
        
        if textField.accessibilityIdentifier == "FirstBox" {
            question.input?.firstBoxInput = textField.text
        } else if textField.accessibilityIdentifier == "SecondBox"{
            question.input?.secondBoxInput = textField.text
        } else {
            question.choice!.choiceList[indexPath.item].input?.firstBoxInput = textField.text
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        let indexPath = tagToIndexPath(tag: textView.tag)
        let question = questionsList[indexPath.section]
        question.bigTextBoxText = textView.text
        
    }

    func getDefaultCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell {
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
    

    func getInputChoiceCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, question: Question) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputChoice", for: indexPath)
        let input = question.choice!.choiceList[indexPath.item].input!
        
        if let inputChoiceCell = cell as? InputChoiceTableViewCell {
            let choiceItem = question.choice!.choiceList[indexPath.item]
            inputChoiceCell.firstLabel.text = input.first
            inputChoiceCell.lastLabel.text = input.last
            let inputText = inputChoiceCell.inputText!
            inputText.text = input.firstBoxInput
            inputText.tag = indexToTag(indexPath: indexPath)
            inputText.delegate = self
            if (choiceItem.isSelected) {
                inputChoiceCell.checkLabel.text = "c"
            } else {
                inputChoiceCell.checkLabel.text = " "
            }
        }
        
        return cell

    }
    func getButtonCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath)
        let buttonCell = cell as! ButtonUITableViewCell
        // if it's not the last page show next question button
        if currentPageIndex != (questionsList.count ) {
        
 
            buttonCell.button.setTitle("Next Question", for: UIControl.State.normal)
            buttonCell.button.removeTarget(nil, action: nil, for: .allEvents)

            buttonCell.button.addTarget(self, action: #selector(nextQuestionTouched), for: .touchUpInside)
        // it's the last page so we show redo and finish button
        // first check if it's the second last section
        } else if (indexPath.section == questionsList.count) {
            buttonCell.button.setTitle("Done", for: UIControl.State.normal)
            buttonCell.button.removeTarget(nil, action: nil, for: .allEvents)
            buttonCell.button.addTarget(self, action: #selector(doneQuestionTouched), for: .touchUpInside)
        } else {
            buttonCell.button.setTitle("Restart", for: UIControl.State.normal)
            buttonCell.button.removeTarget(nil, action: nil, for: .allEvents)
            buttonCell.button.addTarget(self, action: #selector(restartTouched), for: .touchUpInside)
        }
        return cell
        }
    @objc func doneQuestionTouched(sender: UIButton) {
        performSegue(withIdentifier: "ToFinishScreen", sender: self)
    }
    @objc func restartTouched(sender: UIButton) {
        performSegue(withIdentifier: "ToFinishScreen", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // the last section is for next button
        if indexPath.section >= questionsList.count {
            return getButtonCell(tableView, cellForRowAt: indexPath)
        }
        // case if it's still in the questions sections
        let question = questionsList[indexPath.section]
        switch question.questionType {
        case .bigText:
            return getBigTextCell(tableView, cellForRowAt: indexPath, question: question)
        
        case .input1TxtField :
            //use same function as 2 textField case
            return getTwoTextFieldCell(tableView, cellForRowAt: indexPath, question: question)
            
        case .input2TxtField :
            return getTwoTextFieldCell(tableView, cellForRowAt: indexPath, question: question)
            
        case .multipleChoice:
            //create fake case for testing remember to delete the line
            if indexPath.item == 0  {
                question.choice?.choiceList[indexPath.item].isInputChoice = true
            }
            if question.choice?.choiceList[indexPath.item].isInputChoice == true {
                return getInputChoiceCell(tableView, cellForRowAt: indexPath, question: question)
            }
            
            return getDefaultCell(tableView, cellForRowAt: indexPath, question: question)
            
        default:
            return getDefaultCell(tableView, cellForRowAt: indexPath, question: question)
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

