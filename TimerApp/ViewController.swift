//
//  ViewController.swift
//  TimerApp
//
//  Created by Sho Nozaki on 2018/09/17.
//  Copyright © 2018年 sho.nozaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // タイマー
    var timer: Timer?
    // 経過時間
    var duration = 0
    // 秒数保持キー
    let SETTING_KEY = "timerValue"
    
    @IBOutlet weak var timeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = UserDefaults.standard
        settings.register(defaults: [SETTING_KEY: 60])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     画面描画終了の処理
      - タイマーをリセットする.
     */
    override func viewDidAppear(_ animated: Bool) {
        duration = 0
        _ = displayUpdate() // 返り値が不要のため
    }
    
    /*
     残り時間を計算する処理
     */
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: SETTING_KEY)
        let remainSeconds = timerValue - duration // 残り時間
        timeDisplay.text = "残り\(remainSeconds)秒"
        return remainSeconds
    }
    
    /*
     タイマーを停止する処理
     */
    @objc func timerStop(_ timer: Timer) {
        duration += 1
        if displayUpdate() <= 0 {
            timer.invalidate() // タイマーの停止
            // TODO: 今後は、タイマー終了時に音で知らせるようにする
        }
    }

    /*
     時間設定
     */
    @IBAction func timerSettingAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate() // タイマーが起動している場合は停止する
            }
        }
        performSegue(withIdentifier: "timerSetting", sender: nil)
    }
    
    /*
     タイマー起動
     */
    @IBAction func startTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            // タイマーの有効確認
            if nowTimer.isValid == true {
                // タイマーが実行中の場合
                return
            }
        }
        // タイマーの生成・起動
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
    }
    
    /*
     タイマー停止
     */
    @IBAction func stopTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            // タイマーの有効確認
            if nowTimer.isValid == true {
                nowTimer.invalidate() // タイマーの停止
            }
        }
    }
    
    /*
     タイマーリセット
     */
    @IBAction func resetTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            // タイマーの有効確認
            if nowTimer.isValid == true {
                // タイマーが実行中の場合
                nowTimer.invalidate() // タイマーの停止
            }
            // タイマーの初期化
            duration = 0
            _ = displayUpdate() // 返り値が不要のため
        }
    }
    
}

