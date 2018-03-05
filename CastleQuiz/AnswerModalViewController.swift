//
//  AnswerModalViewController.swift
//  CastleQuiz
//
//  Created by KENJI IMAI on 2018/02/06.
//  Copyright © 2018年 KENJI IMAI. All rights reserved.
//

import UIKit

class AnswerModalViewController: UIViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var questionTextView: UITextView!
    
    var question: String = ""
    var selectedAnswer: String = ""
    var actualAnswer: String = ""
    var sort: Int! = 0
    var workItem: DispatchWorkItem! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
                
        if selectedAnswer == actualAnswer {
            answerLabel.text = "正解！"
        } else {
            answerLabel.text = "不正解！"
            answerLabel.textColor = UIColor.blue
        }
        questionTextView.text = question
        answerTextView.text = actualAnswer
        
        let dispatchTime = DispatchTime.now() + 2.0
        self.workItem = DispatchWorkItem() { self.close() }
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: self.workItem)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close() {
        self.workItem.cancel()
        
        // 画面を閉じる
        let nvc = presentingViewController as! UINavigationController
        let vc = nvc.viewControllers.last as! QuestionViewController
        if sort == 1 {
            vc.index = vc.index! - 1
        } else {
            vc.index = vc.index! + 1
        }

        vc.total = vc.total! + 1
        if selectedAnswer == actualAnswer {
            vc.ok = vc.ok! + 1
        }

        vc.loadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //ここで閉じるボタン以外をタップした場合でも画面が閉じるように処理を記載
        //tagで管理するとコードが書きやすい
        super.touchesEnded(touches, with: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            if tag == 1 {
                // 画面を閉じる
                self.close()
            }
        }
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.close()
    }
}
