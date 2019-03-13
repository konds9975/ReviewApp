//
//  QuestionVC.swift
//  ReviewApp
//
//  Created by Kondya on 12/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit


class QuestionVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ThankYouVCDelegate,GooogeReviewVCDelegate {

    var questionArray : [QuestionInfo]!
    
    var submitBtnClick = ""
    
    
    @IBOutlet weak var questionCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionCollection.delegate = self
        self.questionCollection.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.questionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.questionCollection.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as? QuestionCell {
            let model = self.questionArray[indexPath.row]
            cell.emojiImage.image = UIImage(named: "")
            cell.ratingLbl.text = ""
            cell.questionLbl.text  = model.question
            if let rating = model.starRating {
                cell.update(rating: rating)
            }else{
                cell.update(rating: 0.0)
            }
            cell.cosmosViewFull.settings.fillMode = .full
            cell.cosmosViewFull.didFinishTouchingCosmos = {  rating in
                model.starRating = rating
                
               cell.update(rating: rating)
                
            }
            
            if indexPath.row == self.questionArray.count-1 {
                cell.submitBtn.isHidden = false
            }else{
                cell.submitBtn.isHidden = true
            }
            cell.submitBtn.tag = indexPath.row
            cell.submitBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return cell
            
        }else{
            
            return QuestionCell()
            
        }
    }
    @objc func buttonAction(sender: UIButton) {
       
        if self.questionArray[sender.tag].starRating == nil {
            self.alert(message: answerQue)
        }else{
            
            
            UIPasteboard.general.string = self.bindReviewText().0
            
            print(self.bindReviewText().1)
            if self.bindReviewText().1 > 2.6 {
                
                let uiAlert = UIAlertController(title: "Your review avarage rating above than 60% so please paste your review on google", message: "", preferredStyle: UIAlertController.Style.alert)
                self.present(uiAlert, animated: true, completion: nil)
                
                uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                   
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "GooogeReviewVC") as? GooogeReviewVC
                    {
                        self.submitBtnClick = "YES"
                        vc.delegate = self
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }))
                
                uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThankYouVC") as? ThankYouVC {
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.delegate = self
                        self.present(vc, animated: false, completion: nil)
                    }
                    
                }))
                
                
                
                
                
            }
            else{
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThankYouVC") as? ThankYouVC {
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.delegate = self
                    self.present(vc, animated: false, completion: nil)
                }
            }
            

        }
        
        
    }
    func bindReviewText() -> (String,Double) {
        
        var reviewaText = ""
        var reviewRatingTotal = 0.0
        for temp in self.questionArray{
            if let rating = temp.starRating {
                
                reviewaText.append("Que : ")
                reviewaText.append(temp.question ?? "")
                reviewaText.append("\n")
                reviewaText.append("Ans : ")
                if rating == 1.0 {
                   reviewRatingTotal = reviewRatingTotal+rating
                    reviewaText.append("Poor")
                } else if rating == 2.0 {
                    reviewRatingTotal = reviewRatingTotal+rating
                    reviewaText.append("Below Average")
                } else if rating == 3.0 {
                    reviewRatingTotal = reviewRatingTotal+rating
                    reviewaText.append("Average")
                } else if rating == 4.0 {
                    reviewRatingTotal = reviewRatingTotal+rating
                    reviewaText.append("Above Average")
                } else if rating == 5.0 {
                    reviewRatingTotal = reviewRatingTotal+rating
                    reviewaText.append("Excellent")
                }
                reviewaText.append("\n")
            }
       
        }
        
        let avarage = (reviewRatingTotal/Double(self.questionArray.count))
        return (reviewaText,avarage)
    }
    func getGooogeReviewVCResultSuccess() {
        
        if self.submitBtnClick == "YES" {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThankYouVC") as? ThankYouVC {
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegate = self
                self.present(vc, animated: false, completion: nil)
            }
           
        }else{
             self.getThankYouVCDelegate()
        }
    }
    func getThankYouVCDelegate() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as? QuestionVC {
            vc.questionArray = self.getQuestion()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navigationController = UINavigationController(rootViewController: vc)
            appDelegate.window?.rootViewController = navigationController
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    func stopScroll() {
        self.questionCollection.isScrollEnabled = false;
        self.questionCollection.isScrollEnabled = true;
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.questionCollection.contentOffset, size: self.questionCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = self.questionCollection.indexPathForItem(at: visiblePoint)
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
            print("left")
        } else {
            print("right")
            if self.questionArray[indexPath?.row ?? 0].starRating == nil {
                self.stopScroll()
                self.alert(message: answerQue)
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.questionCollection.contentOffset, size: self.questionCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = self.questionCollection.indexPathForItem(at: visiblePoint)
        self.navigationItem.title = "Question \((indexPath?.row ?? 0)+1)"
  
    }

}
