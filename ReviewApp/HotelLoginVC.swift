//
//  ViewController.swift
//  ReviewApp
//
//  Created by Kondya on 12/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit

class HotelLoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailText.delegate = self
        self.passwordText.delegate = self
        self.emailText.text = "admin@admin.com"
        self.passwordText.text = "Admin@1234"
    }

    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        if (self.emailText.text?.trimmingCharacters(in: .whitespaces).count == 0){
            self.alert(message: emptyEmailValidationMessage)
        }
        else
            if !(self.emailText.text?.isValidEmail() ?? false){
                self.alert(message: invalidEmailValidationMessage)
        }
        else
                if (self.passwordText.text?.trimmingCharacters(in: .whitespaces).count == 0){
                    self.alert(message: passwordValidationMessage)
        }
        else{
        if (self.emailText.text == "admin@admin.com" && self.passwordText.text == "Admin@1234"){
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as? QuestionVC {
                vc.questionArray = self.getQuestion()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let navigationController = UINavigationController(rootViewController: vc)
                appDelegate.window?.rootViewController = navigationController
            }
                        
        }
        else{
            
                self.alert(message: passEmailValidationMessage)
        }
      }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}









import Foundation

let answerQue = "Please give rating for this question"
let emptyEmailValidationMessage = "Please enter email"
let invalidEmailValidationMessage = "Please enter valid email"
let passwordValidationMessage = "Please enter password"
let passEmailValidationMessage = "Please enter valid email and password"
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    
    func getQuestion()->[QuestionInfo]{
        let temp1 = QuestionInfo(question: "How was the service?", starRating: nil)
        let temp2 = QuestionInfo(question: "How was the behaviour of staff?", starRating: nil)
        let temp3 = QuestionInfo(question: "How is restaurant ambience?", starRating: nil)
        let temp4 = QuestionInfo(question: "How was our food today?", starRating: nil)
        return [temp1,temp2,temp3,temp4]
        
    }
}
