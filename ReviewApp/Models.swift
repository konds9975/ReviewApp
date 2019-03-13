//
//  Models.swift
//  ReviewApp
//
//  Created by Kondya on 12/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import Foundation

class QuestionInfo {
    
    var question : String?
    var starRating : Double?
    init(question : String?,starRating : Double?) {
        self.question = question
        self.starRating = starRating
        
    }
    
}
