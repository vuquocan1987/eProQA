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
    var question: Question
    init (data:JSON) {
        pageNumber = data[JSONKey.number].intValue
        text = data[JSONKey.text].string
        subtext = data[JSONKey.sub_text].string
        if data[JSONKey.question][JSONKey.text].string == nil {
        }
        question = Question(data: data[JSONKey.question])
    }
    func pickAnswer(forQuestionAtIndex qIndex: Int, withAnswerAtIndex aIndex: Int){
        
    }
    func getQuestionList() -> [Question] {
        var qList = [Question]()
        qList.append(question)
        if let subQuestions = question.subQuestions {
            for q in subQuestions {
                qList.append(q)
            }
        }
        return qList
        
    }
}
