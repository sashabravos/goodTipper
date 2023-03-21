//
//  CalculateViewController.swift
//  goodTipper
//
//  Created by Александра Кострова on 04.03.2023.
//

import UIKit

final class CalculateViewController: UIViewController {

    private var calculateView: CalculateView!
    public var tip = 0.10
    public var people = 2
    public var totalBillAsANumber = Double()
    public var finalResult = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSubviews()
    }
    
    private func setSubviews() {
        self.calculateView = CalculateView()
        self.calculateView.delegate = self
        view.addSubview(calculateView)
        
        calculateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.calculateView.topAnchor.constraint(equalTo: view.topAnchor),
            self.calculateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.calculateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.calculateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CalculateViewController: CalculateViewDelegate {
    
    func tipButtonChanged(tipButton: UIButton) {
        
        calculateView.billTF.endEditing(true)
        
        [ calculateView.smallTip, calculateView.middleTip, calculateView.bigTip ].forEach {
                        $0.isSelected = false
                        $0.backgroundColor = .clear
                    }
        
        tipButton.isSelected = true
        tipButton.backgroundColor = MyView.Constants.primaryTextColor
        
        let buttonTitle = tipButton.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100 + 1.0
    }
    
    func stepperValueChanged(stepper: UIStepper) {
        people = Int(stepper.value)
        calculateView.numberOfPeple.text = String(people)
    }
    
    func calculateButtonPressed(button: UIButton) {
        let bill = calculateView.billTF.text!
        if bill != "" {
            totalBillAsANumber = Double(bill)!
            let result = totalBillAsANumber * tip / Double(people)
            finalResult = String(format: "%.2f", result)
        }
        
        print(totalBillAsANumber, tip, people, "1st VC")
        let resultView = ResultView()
        resultView.result = finalResult
        resultView.tip = Int(tip * 100)
        resultView.people = people
        print(resultView.result, resultView.tip, resultView.people, "2nd VC in 1st VC")
        self.present(ResultViewController(calculateVC: CalculateViewController()), animated: true)}
}
