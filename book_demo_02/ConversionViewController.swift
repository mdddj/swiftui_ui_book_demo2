//
//  ConversionViewController.swift
//  book_demo_02
//
//  Created by ldd on 2022/2/18.
//

import UIKit

class ConversionViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var ceksiusLabel : UILabel!
    @IBOutlet var textField: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("之前输入的文本: \(textField.text)")
//        print("替换的文本是:\(string)")
//        return true
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
    
//        print("之前的文本是否含有小数点:\(existingTextHasDecimalSeparator)")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
//        if existingTextHasDecimalSeparator! == nil && replacementTextHasDecimalSeparator!==nil {
//            return false
//        }
        
//        guard : 守卫者 后面的表达式如果不成立,将执行返回true
        
        guard existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil else {
            return true
        }
        //存在小数点,不进行更新
        return false
    }
    
    
//    添加一个属性存储摄氏度的值,类型是双精度浮点数
    var fahrenHeitValues: Double? {
        //添加属性观察方法,在值进行改变的时候进行更新
        didSet {
            updateCelsiusLable()
        }
    }
    
    @IBAction func fahrenHeitFieldEditingChanged(textField: UITextField) {
//        ceksiusLabel.text = textField.text
        if let text = textField.text, let value=Double(text) {
            fahrenHeitValues = value
        }
        else {
           fahrenHeitValues = nil
        }
    }
    
    /// 获取摄氏度
    var calsiusValues: Double? {
        
        //首先看华摄度是否有值,如果有值进行计算,没有返回nil
        if let value = fahrenHeitValues {
            return (value - 32) * (5/9)
        }else{
            return nil
        }
    }
    
    //添加一个方法来进行更新摄氏度的标签
    func updateCelsiusLable() {
        if let value = calsiusValues {
//            ceksiusLabel.text = "\(value)"
            ceksiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
        else {
            ceksiusLabel.text = "???"
        }
    }
    
    //对用户输入的数字进行格式化
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func viewOnTap(_ sender: Any) {
        print("进来了22")
        textField.resignFirstResponder()
    }
    
    @IBAction func dismissKeyboard(send: AnyObject) {
        print("进来了")
        textField.resignFirstResponder()
    }
}
