//
//  ViewController.swift
//  MyEggTimer
//
//  Created by Nikolai Zvonarev on 31.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7] //Словарь, который содержит в себе названия кнопок и время, требуемое для варки
    var totalTime = 0 //Переменная, содержащая общее время варки
    var secondsPassed = 0 //Переменная, содержащая количество прошедших секунд с момента начала варки
    var timer = Timer()
    var player: AVAudioPlayer!
    
    
    @IBAction func harnessSelected(_ sender: UIButton) {
        timer.invalidate() //Сбрасываем таймер перед новым нажатием на кнопку
        let hardness = sender.currentTitle! //Задаем константу, которая берет название кнопки для дальнейший действий. Используем знак ! для принудительной распаковки значения (чтобы оно не было Optional
        totalTime = eggTime[hardness]! //Берем значение времени варки из словаря eggTime от имени кнопки
        
        progressBar.progress = 0.0 // обнуляем прогресс бар. значение Float
        secondsPassed = 0
        titleLabel.text = hardness // Выводим название нажатой кнопки в верхний лэйбл
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)// Строка содержащая параметры таймера
    }

    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime) //Отсчет таймера
        } else {
            timer.invalidate() // сброс таймера после окончания варки
            titleLabel.text = "DONE!" // Выводим в верхний лейбл
            playSound(soundName: "alarm_sound") // Проигрываем финальную сирену
        }
    
        func playSound(soundName: String) {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } // код для воспроизведения сирены
    }
    
    
    
}

