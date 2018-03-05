//
//  QuestionViewController.swift
//  CastleQuiz
//
//  Created by KENJI IMAI on 2018/02/06.
//  Copyright © 2018年 KENJI IMAI. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    var dataList:[String] = []
    var index: Int! = 0
    var sort: Int! = 0
    var ok: Int! = 0
    var total: Int! = 0
    var answerActual: String = ""
    var dataLabelText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if sort == 1 {
            index = dataList.count - 2
        }
        dataLabel.text = dataLabelText
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toAnswerModal") {
            let amvc: AnswerModalViewController = (segue.destination as? AnswerModalViewController)!
            
            // https://stackoverflow.com/questions/44663002/how-to-present-a-view-controller-with-smaller-size
//            amvc.providesPresentationContextTransitionStyle = true
//            amvc.definesPresentationContext = true
//            amvc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
//            amvc.view.backgroundColor = UIColor.clear
            
            // AnswerModalViewControllerのtextにメッセージを設定
            amvc.actualAnswer = answerActual
            
            let selectedButton: UIButton = sender as! UIButton
            amvc.question = (questionTextView.text)!
            amvc.selectedAnswer = (selectedButton.titleLabel?.text)!
            amvc.sort = sort
            
            resetLabels()
        }
    }
    
    func loadData() {
        if sort == 1 {
//            print(index)
            if 0 > index {
                self.dismiss(animated: false, completion: nil)
                showAlert()
                return
            }
        } else {
//            print(index)
            if dataList.count <= index + 1 {
                self.dismiss(animated: false, completion: nil)
                showAlert()
                return
            }
        }
        
        let data: String = dataList[index]
        let itemArray = data.components(separatedBy: ",")
        
        let question: String = itemArray[0] + ". " + itemArray[1]
        questionTextView.text = question
        
        let answer1: String = "1.  " + itemArray[2]
        let answer2: String = "2.  " + itemArray[3]
        let answer3: String = "3.  " + itemArray[4]
        let answer4: String = "4.  " + itemArray[5]
        answer1Button.setTitle(answer1, for: .normal)
        answer2Button.setTitle(answer2, for: .normal)
        answer3Button.setTitle(answer3, for: .normal)
        answer4Button.setTitle(answer4, for: .normal)
        answer1Button.titleLabel?.numberOfLines = 2
        answer2Button.titleLabel?.numberOfLines = 2
        answer3Button.titleLabel?.numberOfLines = 2
        answer4Button.titleLabel?.numberOfLines = 2
        
        let answerIndex: Int = Int(itemArray[6])!
        answerActual = itemArray[6] + ".  " + itemArray[1 + answerIndex]
        
        if total > 0 {
            questionNumLabel.text = String(ok) + "/" + String(total)
        } else {
            questionNumLabel.text = ""
        }
    }
    
    func resetLabels(){
        answer1Button.setTitle("", for: .normal)
        answer2Button.setTitle("", for: .normal)
        answer3Button.setTitle("", for: .normal)
        answer4Button.setTitle("", for: .normal)
        questionTextView.text = ""
        questionNumLabel.text = ""
    }
    
    func showAlert() {

        let alert = UIAlertController(title: "全問終了！", message: "トップページへ.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:
            { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }
        ))
            
        self.present(alert, animated: false)
    }
}
