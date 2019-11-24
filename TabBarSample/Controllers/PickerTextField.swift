//
//  PickerTextField.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/11/24.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation
import UIKit

class PickerTextField: UITextField {
    
    private var dataList = [String]()
    
    
    init() {
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setup(dataList: [String]) {
        self.dataList = dataList
        
        let pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(done))
        toolBar.setItems([doneButton], animated: true)
        
        self.inputView = pickerview
        self.inputAccessoryView = toolBar
    }
    
    @objc func done() {
        self.endEditing(true)
    }
    
    @objc func cancel() {
        self.text = ""
        self.endEditing(true)
    }
}

extension PickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = self.dataList[row]
    }
}
