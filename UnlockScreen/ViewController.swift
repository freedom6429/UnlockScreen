//
//  ViewController.swift
//  UnlockScreen
//
//  Created by Wen Luo on 2022/1/13.
//

import UIKit

class ViewController: UIViewController {
    
    //設定正確密碼為一個陣列
    let password = [0, 0, 0, 0]
    //使用者輸入數字也是用一個陣列存起來，一開始目前是空的
    var userInputs: [Int] = []
    //四個無臉男圖片檔案名稱存入陣列
    let facelessMenFileNames = ["facelessMan1.png", "facelessMan2.png", "facelessMan3.png",  "facelessMan4.png"]
    //建立好用來顯示無臉男圖片的imageViews陣列
    var digitImageViews: [UIImageView] = []

    //密碼圖像區塊View outlet
    @IBOutlet weak var firstDigitView: UIView!
    
    @IBOutlet weak var secondDigitView: UIView!
    
    @IBOutlet weak var thirdDigitView: UIView!
    
    @IBOutlet weak var fourthDigitView: UIView!
    
    //數字0~9和刪除button outlet
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
    
    //四個無臉男圖片imageView outlet
    @IBOutlet weak var firstDigitImageView: UIImageView!
    
    @IBOutlet weak var secondDigitImageView: UIImageView!
    
    @IBOutlet weak var thirdDigitImageView: UIImageView!
    
    @IBOutlet weak var fourthDigitImageView: UIImageView!
    
    //放大刪除按鈕圖片的函式
    func enlargeDeleteButtonImage() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        let largeDeleteIcon = UIImage(systemName: "delete.backward.fill", withConfiguration: largeConfig)
        deleteButton.setImage(largeDeleteIcon, for: .normal)
    }
    
    //根據使用者輸入數字個數來顯示無臉男圖片
    func showDigitImage() {
        //先將所有密碼圖片View放到一個陣列中
        let digitViews = [firstDigitView, secondDigitView, thirdDigitView, fourthDigitView]
        //根據userInputs的數量來顯示哪幾個無臉男圖片要顯示出來
        for index in 0...userInputs.count - 1 {
            let view = digitViews[index]
            view?.backgroundColor = UIColor.clear
            digitImageViews[index].isHidden = false
        }
    }
    
    //隱藏所有無臉男圖片
    func hideAllDigitImages() {
        let digitViews = [firstDigitView, secondDigitView, thirdDigitView, fourthDigitView]
        for index in 0...digitViews.count - 1 {
            let view = digitViews[index]
            view?.backgroundColor = UIColor.systemGray4
            digitImageViews[index].isHidden = true
        }
    }
    
    //check密碼輸入是否正確的函式，只在userInputs長度為4時觸發檢查
    func checkInputsCount() {
        if userInputs.count < 4 {
            return
        } else if userInputs.count == 4 {
            if userInputs == password {
                //密碼輸入正確會顯示「解鎖成功」
                resultLabel.text = "解鎖成功"
                resultLabel.isHidden = false
                
            } else {
                //密碼輸入錯誤清空userInputs並且顯示錯誤訊息
                //因為userInputs清空所以無臉男會全部消失
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
        //將四個密碼圖片區塊用mask做出無臉男的剪影和無臉男的圖片
        //將按鈕的數字放大
        //放大刪除按鈕的圖案、隱藏結果訊息label
        let numberButtons = [zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        let digitViews = [firstDigitView, secondDigitView, thirdDigitView, fourthDigitView]
        digitImageViews = [firstDigitImageView, secondDigitImageView, thirdDigitImageView, fourthDigitImageView]
        for index in 0...digitViews.count - 1 {
            let mask = UIImageView(image: UIImage(named: facelessMenFileNames[index]))
            digitViews[index]!.mask = mask
            digitImageViews[index].frame = CGRect(origin: .zero, size: mask.frame.size)
            digitImageViews[index].isHidden = true
        }
        for index in 0...numberButtons.count - 1  {
            var title = AttributedString(String(index))
            title.font = UIFont(name: "Helvetica", size: 30)
            numberButtons[index]?.setAttributedTitle(NSAttributedString(title), for: .normal)
        }
        enlargeDeleteButtonImage()
        resultLabel.isHidden = true
    }

    @IBAction func inputNumberButtons(_ sender: UIButton) {
        //檢查userInputs如果長度為4就直接結束action，用在解鎖成功的時
        if userInputs.count == 4 {
            return
        }
        //輸入數字時要清空之前的結果訊息
        resultLabel.text = ""
        //從button的attributedTitle擷取按了哪個數字
        let userInput = sender.attributedTitle(for: .normal)?.string
        //字串轉為整數型態
        let userInputInt = Int(userInput!)!
//        print(userInputInt)
        //加到userInputs陣列中
        userInputs.append(userInputInt)
//        print(userInputs)
        //根據輸入了幾個密碼位數來顯示幾個無臉男
        showDigitImage()
        //加入陣列後後再次確認長度，必要時就核對密碼
        checkInputsCount()
        
    }
    
    @IBAction func deleteOneDigit(_ sender: Any) {
        //如果長度為0就代表不用作用，直接return
        if userInputs.count == 0 {
            return
        }
        //刪除時也清空結果訊息
        resultLabel.text = ""
        //彈出userInpus最後一個位數，_代表return出來的東西後續不再使用
        let _ = userInputs.popLast()
//        print(userInputs)
        //處理完之後再檢查一次userInputs，如果為0就隱藏全部無臉男
        //如果不為0就先全部隱藏後再顯示對應數量的無臉男
        if userInputs.count == 0 {
            hideAllDigitImages()
        } else {
            hideAllDigitImages()
            showDigitImage()
        }
    }
    
}

