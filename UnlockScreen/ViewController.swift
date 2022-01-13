//
//  ViewController.swift
//  UnlockScreen
//
//  Created by Wen Luo on 2022/1/13.
//

import UIKit

class ViewController: UIViewController {
    
    let password = [0, 0, 0, 0]
    var userInputs: [Int] = []
    let facelessMenFileNames = ["facelessMan1.png", "facelessMan2.png", "facelessMan3.png",  "facelessMan4.png"]
    var digitImageViews: [UIImageView] = []

    
    @IBOutlet weak var firstDigitView: UIView!
    
    @IBOutlet weak var secondDigitView: UIView!
    
    @IBOutlet weak var thirdDigitView: UIView!
    
    @IBOutlet weak var fourthDigitView: UIView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var oneButton: UIButton!
    
    @IBOutlet weak var twoButton: UIButton!
    
    @IBOutlet weak var threeButton: UIButton!
    
    @IBOutlet weak var fourButton: UIButton!
    
    @IBOutlet weak var fiveButton: UIButton!
    
    @IBOutlet weak var sixButton: UIButton!
    
    @IBOutlet weak var sevenButton: UIButton!
    
    @IBOutlet weak var eightButton: UIButton!
    
    @IBOutlet weak var nineButton: UIButton!
    
    @IBOutlet weak var zeroButton: UIButton!
    
    @IBOutlet weak var firstDigitImageView: UIImageView!
    
    @IBOutlet weak var secondDigitImageView: UIImageView!
    
    @IBOutlet weak var thirdDigitImageView: UIImageView!
    
    @IBOutlet weak var fourthDigitImageView: UIImageView!
    
    
    func enlargeDeleteButtonImage() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        let largeDeleteIcon = UIImage(systemName: "delete.backward.fill", withConfiguration: largeConfig)
        deleteButton.setImage(largeDeleteIcon, for: .normal)
    }
    
    
    func showDigitImage() {
        //要先知道是輸入到第幾位
        let digitViewArray = [firstDigitView, secondDigitView, thirdDigitView, fourthDigitView]
        for index in 0...userInputs.count - 1 {
            let view = digitViewArray[index]
            view?.backgroundColor = UIColor.clear
            digitImageViews[index].isHidden = false
        }
    }
    
    func hideAllDigitImages() {
        let digitViewArray = [firstDigitView, secondDigitView, thirdDigitView, fourthDigitView]
        for index in 0...digitViewArray.count - 1 {
            let view = digitViewArray[index]
            view?.backgroundColor = UIColor.systemGray4
            digitImageViews[index].isHidden = true
        }
    }
    
    func checkInputsCount() {
        if userInputs.count < 4 {
            return
        } else if userInputs.count == 4 {
            if userInputs == password {
                resultLabel.text = "解鎖成功"
                resultLabel.isHidden = false
                
            } else {
                userInputs = []
                resultLabel.text = "密碼錯誤，請再輸入一次"
                resultLabel.isHidden = false
                hideAllDigitImages()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let numberButtonArray = [zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        let digitViews = [firstDigitView, secondDigitView, thirdDigitView, fourthDigitView]
        digitImageViews = [firstDigitImageView, secondDigitImageView, thirdDigitImageView, fourthDigitImageView]
        for index in 0...digitViews.count - 1 {
            let mask = UIImageView(image: UIImage(named: facelessMenFileNames[index]))
            digitViews[index]!.mask = mask
            digitImageViews[index].frame = CGRect(origin: .zero, size: mask.frame.size)
            digitImageViews[index].isHidden = true
        }
        for index in 0...numberButtonArray.count - 1  {
            var title = AttributedString(String(index))
            title.font = UIFont(name: "Helvetica", size: 30)
            numberButtonArray[index]?.setAttributedTitle(NSAttributedString(title), for: .normal)
        }
        enlargeDeleteButtonImage()
        resultLabel.isHidden = true
    }

    @IBAction func inputNumberButtons(_ sender: UIButton) {
        if userInputs.count == 4 {
            return
        }
        resultLabel.text = ""
        let userInput = sender.attributedTitle(for: .normal)?.string
        let userInputInt = Int(userInput!)!
        print(userInputInt)
        userInputs.append(userInputInt)
        print(userInputs)
        showDigitImage()
        checkInputsCount()
        
    }
    
    @IBAction func deleteOneDigit(_ sender: Any) {
        if userInputs.count == 0 {
            return
        }
        resultLabel.text = ""
        let _ = userInputs.popLast()
        print(userInputs)
        if userInputs.count == 0 {
            hideAllDigitImages()
        } else {
            hideAllDigitImages()
            showDigitImage()
        }
    }
    
}

