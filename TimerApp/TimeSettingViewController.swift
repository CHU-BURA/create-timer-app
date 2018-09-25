//
//  TimeSettingViewController.swift
//  TimerApp
//
//  Created by Sho Nozaki on 2018/09/25.
//  Copyright © 2018年 sho.nozaki. All rights reserved.
//

import UIKit

class TimeSettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // 時間設定値(秒) TODO: 分指定も可能にしたい
    let timeArray: [Int] = [10, 30, 60, 120, 180]
    // 設定値保持キー
    let SETTING_KEY = "timerValue"
    
    @IBOutlet weak var timePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UIPickerView設定
        timePicker.delegate = self
        timePicker.dataSource = self
        
        // 格納データの取得
        let settings = UserDefaults.standard
        let timerSetting = settings.integer(forKey: SETTING_KEY)
        
        // 時間設定の秒数指定
        for row in 0..<timeArray.count {
            if timeArray[row] == timerSetting {
                timePicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    PickerViewの列数指定
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 時間設定のみのため1
    }
    
    /*
     PickerViewの行数指定
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }
    
    /*
     PickerViewの表示設定
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeArray[row])
    }
    
    /*
     PickerView選択時の処理
      - 時間設定値を格納する.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // データ格納
        let settings = UserDefaults.standard
        settings.setValue(timeArray[row], forKey: SETTING_KEY)
        settings.synchronize()
    }
    
    /*
     時間設定を確定する処理
     */
    @IBAction func timePickerSelectAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true) // 履歴から前画面へ遷移させる
    }
}
