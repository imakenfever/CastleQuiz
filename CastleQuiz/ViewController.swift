//
//  ViewController.swift
//  CastleQuiz
//
//  Created by KENJI IMAI on 2018/02/06.
//  Copyright © 2018年 KENJI IMAI. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    var index: Int! = 0
    
    var dataList:[String] = []
    var list = [
        ["3級第5回", "3_5"],
        ["2級第4回", "2_4"],
        ["2級第5回", "2_5"],
        ["2級第6回", "2_6"],
        ["準1級第2回", "j1_2"],
        ["準1級第4回", "j1_4"],
        ["準1級第6回", "j1_6"],
        ["1級第6回", "1_6"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // はじめに表示する項目を指定
        dataLabel.text = "2級第4回"
        dataPickerView.selectRow(1, inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        var selectedList = list[index]
        dataList = loadCSV(filename: selectedList[1])
        
        if (segue.identifier == "toQuestionViewController") {
            let qvc: QuestionViewController = (segue.destination as? QuestionViewController)!
            // QuestionViewControllerのdataListにメッセージを設定
            qvc.dataList = dataList
            qvc.dataLabelText = dataLabel.text!
            qvc.sort = sortSegmentedControl.selectedSegmentIndex
        }
    }

    //CSVファイルの読み込みメソッド。引数にファイル名、返り値にString型の配列。
    func loadCSV(filename:String)->[String]{
        //CSVファイルを格納するための配列を作成
        var csvArray:[String] = []
        //CSVファイルの読み込み
        let csvBundle = Bundle.main.path(forResource: filename, ofType: "csv", inDirectory: "data")
        
        do {
            //csvBundleのパスを読み込み、UTF8に文字コード変換して、NSStringに格納
            let csvData = try String(contentsOfFile: csvBundle!,
                                     encoding: String.Encoding.utf8)
            //改行コードが"\r"で行なわれている場合は"\n"に変更する
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            //"\n"の改行コードで区切って、配列csvArrayに格納する
            csvArray = lineChange.components(separatedBy: "\n")
        }
        catch {
            print("エラー")
        }
        return csvArray
    }
    
    
    // UIPickerViewDataSource
    
    // Picerviewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Picker View の行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    // UIPickerViewDelegate
    
    //表示する文字列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return list[row][0]
    }

    //選択した時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
        dataLabel.text = list[row][0]
    }
}

