//
//  Questionaire.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/9/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import Foundation
import SwiftyJSON
class Questionaire {
    var title: String
    var explainText: String
    var subtext: String?
    var textForKid: String?
    var questionNoText: String
    var questionCount: Int
    var timeLength: Int
    var questionPages: [QuestionPage]
    init(data: JSON) {
        title = data[JSONKey.title].stringValue
        explainText = data[JSONKey.text].stringValue
        questionNoText = data[JSONKey.question_no_text].stringValue
        
        subtext = data[JSONKey.sub_text].string
        textForKid = data[JSONKey.title].string
        
        questionCount = data[JSONKey.all_questions].intValue
        timeLength = data[JSONKey.length_of_time].intValue
        
        let questionPagesJSON = data[JSONKey.page].arrayValue
        questionPages = [QuestionPage]()
        for pageData in questionPagesJSON {
            questionPages.append(QuestionPage(data: pageData))
        }
        
        QuestionPage(data: data[JSONKey.page])
    
    }
   
}


struct JSONKey {
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
    static let number = "number"
    static let next = "next"
    static let question_type = "question_type"
}
