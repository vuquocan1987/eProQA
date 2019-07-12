//
//  Question.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/8/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import Foundation
import SwiftyJSON
enum QuestionType: Int {
    case multipleChoice = 1
    case subMultipleChoice
    case bigText
    case input1TxtField
    case input2TxtField
    case yesNo
    
    case inputMultiple
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
    var bigTextBoxText: String?
    init (data: JSON) {
        questionID = data[JSONKey.question_no].string
        text = data[JSONKey.text].string
        subtext = data[JSONKey.sub_text].string
        choice = Choice(data: data[JSONKey.choice])
        input = Input(data: data[JSONKey.input])
        
        if let subQuestionsData = data[JSONKey.sub_questions].array {
            subQuestions = [Question]()
            for questionData in subQuestionsData {
                let qData = questionData[JSONKey.question]
                
                if qData[JSONKey.text].string == nil {
                    
                }
                subQuestions!.append(Question(data: qData))
            }
        } else {
            subQuestions = nil
        }
        let questionTypeRawValue = data[JSONKey.question_type].int!
        questionType = QuestionType(rawValue: questionTypeRawValue)!
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
    var isInputChoice: Bool
    var inputText: String?
    var itemNumber: String
    var itemText: String
    var subtext: String?
    var next: String?
    var isSelected = false
    var input: Input?
    mutating func setIsSelected(value: Bool ){
        isSelected = value
    }
    mutating func setIsInputChoice(value: Bool) {
        isInputChoice = value
    }
    init(data: JSON) {
        itemNumber = data[JSONKey.item_no].stringValue
        itemText = data[JSONKey.item_text].stringValue
        subtext = data[JSONKey.sub_text].string
        next = data[JSONKey.next].string
        input = Input(data: data[JSONKey.input])
        isInputChoice = false
    }
}
struct Input {
    
    var first: String?
    var last: String?
    var center: String?
    
    var firstBoxInput: String?
    var secondBoxInput: String?
    var placeholder: String?
    init (data: JSON) {
        
            first = data[JSONKey.first].string
                
            last = data[JSONKey.last].string

            center = data[JSONKey.center].string
        
    }
}
