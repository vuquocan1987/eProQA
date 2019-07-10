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
class QA1_1PageQuestionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
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
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // remember to fix this
        if section == (tableView.numberOfSections - 1 ) {
            return 1
        } else {
            return currentPage.question.choice!.choiceList.count
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questionsList[0].choice?.selectChoice(index: indexPath.item)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "hello"    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // +1 for the next question button
        return 1 + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == tableView.numberOfSections - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nextButton", for: indexPath)
            if let nextButtonCell = cell as? NextButtonUITableViewCell {
                nextButtonCell.nextQuestionButton.setTitle("Next Question", for: UIControl.State.normal)
                nextButtonCell.nextQuestionButton.addTarget(self, action: #selector(nextQuestionTouched), for: .touchUpInside)
            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionChoice", for: indexPath)
            if let answerCell = cell as? AnswerTableViewCell {
                let choiceItem = currentPage.question.choice!.choiceList[indexPath.item]
                answerCell.textChoiceLabel.text = choiceItem.itemText
                if (choiceItem.isSelected) {
                answerCell.checkLabel.text = "c"
                } else {
                    answerCell.checkLabel.text = " "
                }
            }
            
            return cell
        }
    }
    @objc func nextQuestionTouched(sender: UIButton) {
        if let navController = navigationController as? QuestionsUINavigationViewController {
            navController.goToNextQuestion(sender: self)
        }
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
        
        stepView.totalStep = pageList.count
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

