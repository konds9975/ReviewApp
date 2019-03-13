//
//  QuestionCell.swift
//  ReviewApp
//
//  Created by Kondya on 12/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit
import Cosmos
class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var cosmosViewFull: CosmosView!
    @IBOutlet weak var emojiImage: UIImageView!
    
    func update(rating:Double)  {
         self.cosmosViewFull.rating = rating
        
        if rating == 1.0 {
            self.emojiImage.image = UIImage(named: "1")
            self.ratingLbl.text = "Poor"
        } else if rating == 2.0 {
            self.emojiImage.image = UIImage(named: "2")
             self.ratingLbl.text = "Below Average"
        } else if rating == 3.0 {
            self.emojiImage.image = UIImage(named: "3")
             self.ratingLbl.text = "Average"
        } else if rating == 4.0 {
            self.emojiImage.image = UIImage(named: "4")
             self.ratingLbl.text = "Above Average"
        } else if rating == 5.0 {
            self.emojiImage.image = UIImage(named: "5")
             self.ratingLbl.text = "Excellent"
        }
        
        self.emojiImage.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.5) {
            self.emojiImage.transform = CGAffineTransform.init(translationX: 1.5, y: 1.5)
            
        }
        
    }
    
    
}
