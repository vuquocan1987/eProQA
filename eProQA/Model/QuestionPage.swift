//
//  Question.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/8/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import Foundation
import SwiftyJSON
class QuestionPage {
    var pageNumber: Int
    var text: String?
    var subtext: String?
    var input: String?
    var question: Question?
    init (data:JSON) {
        pageNumber = data[JSONKey.number].intValue
        text = data[JSONKey.text].string
        subtext = data[JSONKey.sub_text].string
        question = Question(data: data[JSONKey.question])
    }
    func pickAnswer(forQuestionAtIndex qIndex: Int, withAnswerAtIndex aIndex: Int ){
        
    }
}
enum QuestionType {
    case multipleChoice
    case yesNo
    case subMultipleChoice
    case input
}
class Question {
    var questionType: QuestionType
    var answer: String?
    var questionID: String?
    var text: String?
    var subtext: String?
    var choice: Choice?
    var input: Input?
    var subQuestions: [Question]?
    init (data: JSON) {
        questionID = data[JSONKey.question_no].string
        text = data[JSONKey.text].string
        subtext = data[JSONKey.sub_text].string
        choice = Choice(data: data[JSONKey.choice])
        input = nil
        subQuestions = nil
        if input != nil {
            questionType = .input
        } else if subQuestions != nil {
            questionType = .subMultipleChoice
        } else if choice != nil {
            questionType = .multipleChoice
        } else {
            questionType = .yesNo
        }
    }
}
struct Choice {
    var choiceList: [ChoiceItem]
    var startText: String?
    var endText: String?
    init (data: JSON) {
        startText = data[JSONKey.start_text].string
        endText = data[JSONKey.end_text].string
        choiceList = [ChoiceItem]()
        if let choicesData = data[JSONKey.choices].array {
            for choiceData in choicesData {
                choiceList.append(ChoiceItem(data: choiceData))
            }
        }
    }
    mutating func selectChoice(index: Int) {
        for index in 0..<choiceList.count {
            choiceList[index].isSelected = false
        }
        choiceList[index].isSelected = true
    }
}
struct ChoiceItem {
    var itemNumber: String
    var itemText: String
    var subtext: String?
    var next: String?
    var isSelected = false
    mutating func setIsSelected(value: Bool ){
        isSelected = value
    }
    init(data: JSON) {
        itemNumber = data[JSONKey.item_no].stringValue
        itemText = data[JSONKey.item_text].stringValue
        subtext = data[JSONKey.sub_text].string
        next = data[JSONKey.next].string
    }
}
struct Input {
    var text: String?
    var placeholder: String?
}
