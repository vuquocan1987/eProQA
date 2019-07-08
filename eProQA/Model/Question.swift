//
//  Question.swift
//  eProQA
//
//  Created by Rikkeisoft on 7/8/19.
//  Copyright © 2019 Vu Quoc An. All rights reserved.
//

import Foundation
struct Question {
    var number: String
    var text: String
    var subtext: String
    var choice: Choice?
    var input: String?
    var sub_questions: [Question]?
}
struct Choice {
    var choiceList: [ChoiceItem]
    var start_text: String
    var end_text: String
}
struct ChoiceItem {
    var item_no: String
    var item_text: String
    var sub_text: String?
    var next: String?
}
